const triggerModal = () => {
  $('body').on('click', '.static-popup-link', function(){
    $('#showModal').modal('show');
  });
};

export { triggerModal };
