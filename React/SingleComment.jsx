import React, { useState } from "react";
import PropTypes from "prop-types";
import commentService from "services/commentService";
import toastr from "toastr";
import { Formik, Form, Field, ErrorMessage } from "formik";
import debug from "sabio-debug";
import "./comment.scss";
import { Button } from "react-bootstrap";
import { Trash, Edit, MessageSquare } from "react-feather";
import Modal from "react-bootstrap/Modal";
import "../../toastr/build/toastr.css";

function SingleComment(props) {
  const { comment, updateCommentsTree, currentUser } = props;
  const _logger = debug.extend("SingleComment");
  const dateCreated = new Date(comment.dateCreated).toLocaleDateString();
  const minCreated = new Date(comment.dateCreated).toLocaleTimeString();
  const [reveal, setReveal] = useState(false);
  const handleClose = () => setReveal(false);
  const handleShow = () => setReveal(true);

  const defaultReply = {
    subject: "test",
    text: "",
    parentId: comment.id,
    entityTypeId: comment.entityType?.id, //hardcoded until other component is finished
    entityId: comment.entityId,
    CreatedBy: currentUser.id, //hardcoded until other component is finished
    IsDeleted: 0,
    dateCreated: [],
  };

  const updateThisComment = (aNewReply, changedReply) => {
    _logger("updateThisComment", aNewReply, changedReply);
    const updatedReplies = updateReplies(aNewReply, changedReply);
    if (updatedReplies) {
      _logger("updating comment");
      const newComment = { ...props.comment };
      newComment.replies = updatedReplies;
      _logger(newComment.replies);
      _logger("updating comment tree");

      updateCommentsTree(null, newComment);
    } else {
      _logger("Failed to update", props.comment.id);
    }
  };

  //////// Delete Comment ////////

  const onClickDelete = (evt) => {
    _logger(comment);
    evt.stopPropagation();
    // handleShow();
    props.onDeleteClick(comment.id);
  };

  const mapReplies = (comment) => (
    <SingleComment
      comment={comment}
      key={`reply-${comment.id}`}
      updateCommentsTree={updateThisComment}
      currentUser={currentUser}
      onDeleteClick={props.onDeleteClick}
    />
  );

  ////// set show ///////
  const [show, setShow] = useState(false);
  const [editShow, setEditShow] = useState(false);

  const onClickToggleContent = () => {
    setShow(!show);
  };
  const onClickEditContent = () => {
    setEditShow(!editShow);
  };

  ////// create Reply //////
  const [replyData, setReply] = useState({
    ...defaultReply,
  });

  const updateReplies = (aNewReply, changedReply) => {
    _logger(aNewReply);
    _logger("updating replies");
    const updatedReplies = comment?.replies > 0 ? [...comment.replies] : []; //oc
    if (aNewReply) {
      _logger("new reply added");
      updatedReplies.push(aNewReply);
      _logger(updatedReplies);
      return updatedReplies;
    } else if (changedReply) {
      _logger("change added");
      const index = updatedReplies.findIndex(
        (item) => item.id === changedReply.id
      );
      if (index > -1) {
        updatedReplies[index] = changedReply;
        return updatedReplies;
      }
    }
    return null;
  };

  /////// Reply Click ////////
  const onReplyClick = (values) => {
    _logger("Values,", values);
    values.dateCreated = new Date();
    commentService
      .addComment(values)
      .then(onCommentAddSuccess)
      .catch(onCommentAddError);
    _logger(values);
  };

  const onEditClick = (values) => {
    _logger("Update Click Values", values);
    commentService
      .editComment(values.id, values)
      .then(onEditSuccess)
      .catch(onEditError);
  };

  const onCommentAddSuccess = (message) => {
    _logger(message);
    toastr.success("Replys!!!");
    onClickToggleContent();
    updateThisComment(message.item);
    setReply((prevState) => {
      let newRep = { ...prevState };
      newRep.text = "";
      return newRep;
    });
  };

  const onCommentAddError = (err) => {
    _logger("error", err);
    toastr.error("Comment Error");
  };

  const onEditSuccess = (response) => {
    _logger("Edit Success", response);
    toastr.success("Updated!");
  };

  const onEditError = (err) => {
    _logger(err);
    toastr.error("Failed edit");
  };

  /////// edit comment / reply ////////

  return (
    <div className="row">
      <div className={comment.parentId > 0 ? "mx-4 pl-5" : "mx-4"}>
        <img
          className="rounded-circle shadow-1-strong me-3 p-1"
          src={comment?.createdBy?.avatarUrl}
          alt="avatar"
          width="65"
          height="65"
        />
        <div className="flex-grow-1 flex-shrink-1">
          <div className="p-2">
            <div className="d-flex justify-content-between align-items-center">
              <p className="mb-1 mr-1">
                {comment?.createdBy?.firstName +
                  " " +
                  comment?.createdBy?.lastName}{" "}
                <span className="comment-small">
                  {dateCreated} - {minCreated}
                </span>
              </p>
            </div>
            <p className="comment-medium mb-0">{comment.text}</p>
          </div>
        </div>
        <a href="#!">
          <div className="container p-1 row-cols-3">
            <div className="row comment-action comment-small">
              <button
                onClick={onClickToggleContent}
                className="btn bg-colors-gradient btn-sm float-end m-1 p-1 col"
                type="button"
              >
                <MessageSquare />
              </button>
              <button
                onClick={onClickEditContent}
                className="btn bg-colors-gradient btn-sm float-end m-1 p-1 col"
                type="button"
              >
                <Edit />
              </button>
              <>
                <button
                  className="btn bg-colors-gradient btn-sm float-end m-1 p-1 col close-button"
                  type="button"
                  onClick={onClickDelete}
                  id={comment.id}
                >
                  <Trash />
                </button>

                <Modal show={reveal} onHide={handleShow}>
                  <Modal.Header closeButton>
                    <Modal.Title>Modal heading</Modal.Title>
                  </Modal.Header>
                  <Modal.Body>
                    Woohoo, you&apos;re reading this text in a modal!
                  </Modal.Body>
                  <Modal.Footer>
                    <Button variant="secondary" onClick={handleClose}>
                      Close
                    </Button>
                    <Button variant="primary" onClick={handleClose}>
                      Save Changes
                    </Button>
                  </Modal.Footer>
                </Modal>
              </>
              <Formik
                enableReinitialize={true}
                initialValues={replyData}
                onSubmit={onReplyClick}
              >
                <Form noValidate name="chat-form" id="reply-form">
                  {show && (
                    <div className="row-cols-1">
                      <div className="col mb-2 mb-sm-0 m-1">
                        <Field
                          type="text"
                          name="text"
                          className="form-control textarea"
                        />
                        <ErrorMessage name="text" component="div" />
                      </div>
                      <div className="col-sm-auto">
                        <div className="btn-group">
                          <button
                            className="btn btn-success reply-send btn-block p-1 m-1"
                            key="reply"
                            type="submit"
                          >
                            Reply
                          </button>
                        </div>
                      </div>
                    </div>
                  )}
                  {editShow && (
                    <div className="row-cols-1">
                      <div className="col mb-2 mb-sm-0 m-1">
                        <Field
                          type="text"
                          name="text"
                          className="form-control textarea"
                        />
                        <ErrorMessage name="text" component="div" />
                      </div>
                      <div className="col-sm-auto">
                        <div className="btn-group">
                          <button
                            className="btn btn-success reply-send btn-block p-1 m-1"
                            key="reply"
                            type="edit"
                            onSubmit={onEditClick}
                          >
                            Edit
                          </button>
                        </div>
                      </div>
                    </div>
                  )}
                </Form>
              </Formik>
            </div>
          </div>
        </a>
        <div className="row replies">{comment.replies?.map(mapReplies)}</div>
      </div>
    </div>
  );
}

SingleComment.propTypes = {
  comment: PropTypes.shape({
    dateCreated: PropTypes.string,
    id: PropTypes.number,
    entityId: PropTypes.number,
    entityType: PropTypes.shape({
      id: PropTypes.number,
    }),
    createdBy: PropTypes.shape({
      firstName: PropTypes.string,
      lastName: PropTypes.string,
      avatarUrl: PropTypes.string,
    }),
    text: PropTypes.string,
    parentId: PropTypes.number,
    replies: PropTypes.arrayOf(PropTypes.shape({})),
  }),
  renderComments: PropTypes.func,
  entityTypeId: PropTypes.number,
  updateCommentsTree: PropTypes.func,
  onDeleteClick: PropTypes.func,
  setComment: PropTypes.func,
  currentUser: PropTypes.shape({
    id: PropTypes.number,
    avatarUrl: PropTypes.string,
    firstName: PropTypes.string,
    lastName: PropTypes.string,
  }),
};
export default React.memo(SingleComment);
