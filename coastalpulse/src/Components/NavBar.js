import React from 'react';
import './css/Navbar.css';


function Navbar() {
  return (
    <nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-xxl">
    <a class="navbar-brand" href="#">
      <img alt='Coastal Pulse' src='/public/CoastalPulseLogo.jpeg'></img>
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
      <div class="navbar-nav">
        <a class="nav-link active" aria-current="page" href="#">Home</a>
        <a class="nav-link" href="#">Features</a>
        <a class="nav-link" href="#">Pricing</a>
      </div>
    </div>
    <form class="d-flex" role="search">
    <button class="btn btn-outline-success me-2" type="button">Log In</button>
    <button class="btn btn-outline btn-outline-secondary" type="button">Register</button>
  </form>
  </div>
</nav>
  );
}

export default Navbar;
