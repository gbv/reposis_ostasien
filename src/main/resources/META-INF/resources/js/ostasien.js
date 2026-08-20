function replaceMaskedEmails() {
  document.querySelectorAll('span.madress').forEach(span => {
    const address = span.textContent.replace(' [at] ', '@');
    const link = document.createElement('a');
    link.href = `mailto:${address}`;
    link.textContent = address;
    span.replaceWith(link);
  });
}

function ignoreEmptyFieldsOnSubmit(event) {
  const form = event.currentTarget;
  const inputs = form.querySelectorAll('input');
  inputs.forEach(input => {
    if (!input.value) {
      input.dataset.nameBackup = input.name;
      input.removeAttribute('name');
    }
  });
  // Restore field names after the form is submitted
  // setTimeout ensures this runs after the submit event completes
  setTimeout(() => {
    inputs.forEach(input => {
      if (input.dataset.nameBackup) {
        input.name = input.dataset.nameBackup;
        delete input.dataset.nameBackup;
      }
    });
  }, 0);
}

function toggleCollapseIcon(event) {
  const icon = event.currentTarget.querySelector('.toggle-icon');
  if (!icon){
    return;
  }
  icon.classList.toggle('fa-chevron-circle-down');
  icon.classList.toggle('fa-chevron-circle-up');
}

function init() {
  replaceMaskedEmails();
  document.querySelectorAll('div[data-toggle="collapse"]').forEach(div => {
    div.addEventListener('click', toggleCollapseIcon);
  });
}

document.addEventListener('DOMContentLoaded', init);
