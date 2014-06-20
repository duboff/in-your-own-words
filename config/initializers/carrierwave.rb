CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => Rails.application.secrets[:aws_access_key],                        # required
    :aws_secret_access_key  => Rails.application.secrets[:aws_secret_key],                        # required
    :region                 => 'us-west-2',              # optional, defaults to 'us-east-1'
    :host                   => 's3-us-west-2.amazonaws.com',
    :endpoint               => 'https://s3-us-west-2.amazonaws.com'
  }
  if Rails.env.test? || Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  else
    config.storage = :fog
  end

  config.cache_dir = "#{Rails.root}/tmp/uploads"
  config.fog_directory  = Rails.application.secrets[:aws_bucket]                   # required
  # config.s3_access_policy = :public_read
  config.fog_public     = true
  # config.fog_host         = "#{Rails.application.secrets[:aws_url]}/#{Rails.application.secrets[:aws_bucket]}"                                   # optional, defaults to true
  # config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end
