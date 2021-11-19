
$(document).ready(function() {

  // spam protection for mails
  $('span.madress').each(function(i) {
      var text = $(this).text();
      var address = text.replace(" [at] ", "@");
      $(this).after('<a href="mailto:'+address+'">'+ address +'</a>')
      $(this).remove();
  });

  // activate empty search on start page
  $("#project-searchMainPage").submit(function (evt) {
    $(this).find(":input").filter(function () {
          return !this.value;
      }).attr("disabled", true);
    return true;
  });

  // replace placeholder USERNAME with username
  var userID = $("#currentUser strong").html();
  var newTestHref = 'https://reposis-test.gbv.de/ostasien/servlets/solr/select?q=createdby:' + userID + '&fq=objectType:mods';
  $("a[href='https://reposis-test.gbv.de/ostasien/servlets/solr/select?q=createdby:USERNAME']").attr('href', newTestHref);

  var newProdHref = 'https://repository.crossasia.org/servlets/solr/select?q=createdby:' + userID + '&fq=objectType:mods';
  $("a[href='https://repository.crossasia.org/servlets/solr/select?q=createdby:USERNAME']").attr('href', newProdHref);

  // toggle collapse text icon
  $('div[data-toggle="collapse"]').click(function () {
    $(this).find('span.toggle-icon').toggleClass('fa-chevron-circle-down fa-chevron-circle-up');
  })

});
