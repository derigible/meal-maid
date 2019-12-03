// @flow

import * as React from "react";

import { Modal } from "@instructure/ui-overlays";
import { CloseButton, Button } from "@instructure/ui-buttons";
import { Heading } from "@instructure/ui-elements";

export default function StandardEditModal({
  closeModal,
  modalOpen,
  onSave,
  children,
  modalTitle,
  size,
  submitDisabled
}: {
  closeModal: any,
  modalOpen: boolean,
  onSave?: any,
  children: React.Node,
  modalTitle: string,
  size?: size,
  submitDisabled?: boolean
}) {
  const closeButton = () => (
    <CloseButton
      placement="end"
      offset="medium"
      variant="icon"
      onClick={closeModal}
    >
      Close
    </CloseButton>
  );
  return (
    <Modal
      open={modalOpen}
      onDismiss={closeModal}
      size={size}
      label={modalTitle}
      shouldCloseOnDocumentClick
    >
      <Modal.Header>
        {closeButton()}
        <Heading>{modalTitle}</Heading>
      </Modal.Header>
      <Modal.Body>{children}</Modal.Body>
      <Modal.Footer>
        <Button onClick={closeModal}>Close</Button>&nbsp;
        {onSave ? (
          <Button
            variant="primary"
            type="submit"
            onClick={onSave}
            disabled={!!submitDisabled}
          >
            Submit
          </Button>
        ) : null}
      </Modal.Footer>
    </Modal>
  );
}
