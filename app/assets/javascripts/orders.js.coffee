jQuery ->
  Conekta.setPublishableKey($('meta[name="conekta-key"]').attr('content'))
  payment.setupForm()

payment =
  setupForm: ->
    $('#new_order').submit ->
      $('input[type=submit]').attr('disabled', true)
      Conekta.token.create($('#new_order'), conektaSuccessResponseHandler, conektaErrorResponseHandler)
      false

  conektaSuccessResponseHandler: (token) ->
    $('#new_order').append($('<input type="hidden" name="conektaTokenId" />').val(token.id))
    $('#new_order')[0].submit()
  
  conektaErrorResponseHandler: (response) ->
    $('.card-errors').text(response.message).show()
    $('input[type=submit]').attr('disabled', false)