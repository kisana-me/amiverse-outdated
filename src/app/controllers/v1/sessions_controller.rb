class V1::SessionsController < V1::ApplicationController
  before_action :api_logged_out_account, only: %i[ create ]
  before_action :api_logged_in_account, only: %i[ destroy ]

  def new
    render body: nil
  end
  def check
    if @current_account
      account_json = render_to_string(
        partial: 'v1/accounts/account_summary',
        formats: [:json],
        locals: { account: @current_account }
      )
      render json: {
        logged_in: true,
        account: JSON.parse(account_json)
      }
    else
      render json: { logged_in: false }
    end
  end
  def login
    account = Account.find_by(name_id: params[:name_id].downcase,
      deleted: false
    )
    if account && account.authenticate(params[:password])
      log_in account
      render json: { logged_in: true }
    else
      render json: { logged_in: false }
    end
  end
  def logout
    log_out if @current_account
    render json: { logged_in: false }
  end
  # 確認用
  def index
  end
  def update
  end
  def destroy
    render json: { }
  end
end