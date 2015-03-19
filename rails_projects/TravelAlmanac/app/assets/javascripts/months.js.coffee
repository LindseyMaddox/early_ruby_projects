$ ->
  $('#show-best').on 'click', (e) ->
    e.preventDefault()
    $('.month-best').toggle()
