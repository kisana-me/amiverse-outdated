module InvitationManagement
  def check_code(code:)
    current_time = Time.current
    return Invitation.find_by(
      "(uses < max_uses) AND (expires_at IS NULL OR expires_at >= ?) AND code = ? AND deleted = ?",
      current_time, code, false
    )
  end
end