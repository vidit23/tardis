import logging
import time

import numpy as np
cimport numpy as np
from astropy import constants

STUFF = 'Hi'

np.import_array()

ctypedef np.int64_t int_type_t

cdef extern from "cmontecarlo.h":
    ctypedef enum rpacket_status_t:
        TARDIS_PACKET_STATUS_IN_PROCESS = 0
        TARDIS_PACKET_STATUS_EMITTED = 1
        TARDIS_PACKET_STATUS_REABSORBED = 2

    ctypedef struct rpacket_t:
        double nu
        double mu
        double energy
        double r
        double tau_event
        double nu_line
        int_type_t current_shell_id
        int_type_t next_line_id
        int_type_t last_line
        int_type_t close_line
        int_type_t recently_crossed_boundary
        int_type_t virtual_packet_flag
        int_type_t virtual_packet
        double d_line
        double d_electron
        double d_boundary
        rpacket_status_t next_shell_id

    void rpacket_set_nu(rpacket_t *packet, double nu)
    void rpacket_set_mu(rpacket_t *packet, double mu)
    void rpacket_set_energy (rpacket_t * packet, double energy);
    void rpacket_set_r (rpacket_t * packet, double r);
    void rpacket_set_tau_event (rpacket_t * packet, double tau_event);
    void rpacket_set_nu_line (rpacket_t * packet, double nu_line);
  
    double rpacket_get_nu(rpacket_t *packet)
    double rpacket_get_mu(rpacket_t *packet)
    double rpacket_get_energy(rpacket_t *packet)
    double rpacket_get_r(rpacket_t *packet)
    double rpacket_get_tau_event(rpacket_t *packet)
    double rpacket_get_nu_line(rpacket_t *packet)

def convert_to_dict(dictionary):
    cdef rpacket_t packet
    rpacket_set_nu(&packet, dictionary['nu'])
    rpacket_set_mu(&packet, dictionary['mu'])
    rpacket_set_energy(&packet, dictionary['energy'])
    rpacket_set_r(&packet, dictionary['r'])
    rpacket_set_tau_event(&packet, dictionary['tau_event'])
    rpacket_set_nu_line(&packet, dictionary['nu_line'])
    return packet

def call_rpacket_get_nu(nu):
    cdef rpacket_t packet
    packet.nu = nu
    return rpacket_get_nu(&packet)


