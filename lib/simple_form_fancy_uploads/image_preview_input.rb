module SimpleFormFancyUploads
  class ImagePreviewInput < SimpleForm::Inputs::FileInput
    def input
      version = input_html_options.delete(:preview_version)
      use_default_url = options.delete(:use_default_url) || false
      preview_html_options = options.delete(:preview_html) || {}
      link_to_original = options.delete(:link_to_original) || false
      
      out = ''
      if object.send("#{attribute_name}?") || use_default_url
        if link_to_original
          out << template.link_to(template.image_tag(object.send(attribute_name).tap {|o| break o.send(version) if version}.send('url')), object.send(attribute_name).send('url'), preview_html_options)
        else
          out << template.image_tag(object.send(attribute_name).tap {|o| break o.send(version) if version}.send('url'), preview_html_options)
        end
      end
      (out << super).html_safe
    end
  end
end
