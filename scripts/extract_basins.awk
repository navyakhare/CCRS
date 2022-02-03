#!/bin/awk -f 

BEGIN {
  phi1_c=2 ;
  phi2_c=4 ;
  phi3_c=6 ;
  psi1_c=3 ;
  psi2_c=5 ;
  psi3_c=7 ;

  basin_p_low = 0.2;
  basin_p_high = 1.5;
  basin_m_low = -2.5;
  basin_m_high = -1.0;

  basin_a_low = -1.0; basin_a_high= 0.5;
  basin_b_low =  2.0; basin_b_high= 3.2;
  basin_c_low = -1.5; basin_c_high= 1.5;
  basin_d_low = -3.0; basin_d_high= 2.5;

  t_start = 0.0;

  print "#! time  sumabs  sval  sval_old  time_diff";
  s1 = -1 ; s2 = -1; s3 = -1;
  sa1 = -1; sa2 = -1; sa3 = -1;
  sval = -1; saval=-1;
}

{
  #s1=s2=s3=0;
  phi1 = $phi1_c ; phi2 = $phi2_c; phi3 = $phi3_c;
  psi1 = $psi1_c ; psi2 = $psi2_c; psi3 = $psi3_c;
  if ( (phi1 > basin_p_low) && (phi1 < basin_p_high) )  {
       #print "pos"
       s1=1;
       if ( (psi1 > basin_c_low) && (psi1 < basin_c_high) ) { sa1 = 2 }
       else if ( (psi1 < basin_d_low) || (psi1 > basin_d_high) ) { sa1 = 3 }
     } 
  else if ( (phi1 > basin_m_low) && (phi1 < basin_m_high) )   { 
       #print "neg"
       s1=0; 
       if ( (psi1 > basin_a_low) && (psi1 < basin_a_high) ) { sa1 = 0 }
       else if ( (psi1 > basin_b_low) && (psi1 < basin_b_high) ) { sa1 = 1 }
  }

  if ( (phi2 > basin_p_low) && (phi2 < basin_p_high) )  {
       s2=1;
       if ( (psi2 > basin_c_low) && (psi2 < basin_c_high) ) { sa2 = 2 }
       else if ( (psi2 < basin_d_low) || (psi2 > basin_d_high) ) { sa2 = 3 }
  } 
  else if ( (phi2 > basin_m_low) && (phi2 < basin_m_high) )   {
       s2=0;
       if ( (psi2 > basin_a_low) && (psi2 < basin_a_high) ) { sa2 = 0 }
       else if ( (psi2 > basin_b_low) && (psi2 < basin_b_high) ) { sa2 = 1 }
  };

  if ( (phi3 > basin_p_low) && (phi3 < basin_p_high) )  {
       s3=1;
       if ( (psi3 > basin_c_low) && (psi3 < basin_c_high) ) { sa3 = 2 }
       else if ( (psi3 < basin_d_low) || (psi3 > basin_d_high) ) { sa3 = 3 }
  } 
  else if ( (phi3 > basin_m_low) && (phi3 < basin_m_high) )   {
       s3=0;
       if ( (psi3 > basin_a_low) && (psi3 < basin_a_high) ) { sa3 = 0 }
       else if ( (psi3 > basin_b_low) && (psi3 < basin_b_high) ) { sa3 = 1 }
  };
  sval_old=sval;
  saval_old = saval;
  sval = s1*1 + s2*2 + s3*4 
  saval = sa1*1 + sa2*4 + sa3*16; 
   
 
  #   print $1, phi1, psi1, phi2, psi2, phi3, psi3, $8, s1, s2, s3, sa1, sa2, sa3;

  if ( (saval != saval_old))  {
     print  $1, $8, sval, sval_old, s1, s2, s3, " \t", saval, saval_old, sa1, sa2, sa3, "\t", $1-t_start;
     t_start = $1; 
  }
}

