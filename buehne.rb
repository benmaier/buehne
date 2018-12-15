dir1 = "/Users/bfmaier/music/chords/chords/1/"
dir2 = "/Users/bfmaier/music/chords/chords/2/"
drumdir = "/Users/bfmaier/music/808_drum_kit/808_drum_kit/"

base = dir1+"AfterEarth Dm.wav"
flute = dir1+"Flute Down.wav"
tick = drumdir+"hihats/808-HiHats01.wav"
bd = drumdir+"/kicks/808-Kicks01.wav"

riff = "/Users/bfmaier/music/samples/riff_01.wav"
buehne = "/Users/bfmaier/music/samples/dieganzeweltisteinebuehne_more_pauses.wav"

bd_vol = 0
conga_vol = 0
base_vol = 0
clap_vol = 0

flute_0_vol = 0
flute_1_vol = 0
tick_vol = 0
guit_vol = 0

use_bpm 60

live_loop :base do
  with_fx :ixi_techno, phase: 128 do
    rate = 0.25
    sample base, rate: rate, amp: base_vol, pitch: 0
    sleep 2/rate
  end
end

live_loop :clap do
  cue :base
  sleep 0.5
  with_fx :bpf, centre: 70 do
    sample drumdir+"snares/808-Clap07.wav", amp: clap_vol
  end
  sleep 0.5
end

with_fx :echo, decay: 3, phase: 0.75, mix: 0.5 do
  with_fx :reverb, room: 1 do
    live_loop :flute do
      with_fx :krush, cutoff: 70, mix: 1 do
        use_random_seed 212188
        cue :base
        32.times do
          sample flute, rate: (1-2*rand_i(2))*1, num_slices: 32, slice: rand_i(32), attack: 0.2, release: 0.5, amp: flute_0_vol, pitch: +7
          sleep 0.5
        end
      end
    end
  end
end

with_fx :lpf, cutoff: 75 do
  with_fx :echo, decay: 5, phase: 0.75 do
    live_loop :ticking do
      cue :base
      with_fx :panslicer,pan_max: 0.5 do
        sample tick, amp: tick_vol
        if rand_i(2) == 1
          sleep 0.25
        else
          2.times do
            sleep 0.25 / 3.0
            sample tick, amp: tick_vol
          end
          sleep 0.25 / 3.0
        end
      end
    end
  end
end

live_loop :lolo do
  cue :base
  with_fx :hpf, mix: 0 do
    sample dir2+"Flutopia Bm7 [d f# a b] +1octave.wav", rate: 0.5, amp: 0.15*flute_1_vol, attack: 0.25, pitch: 0
    sleep 1
  end
end

live_loop :bd do
  cue :base
  sample bd, amp: bd_vol
  if rand_i(32) != 1
    sleep 0.5
  else
    3.times do
      sleep 0.5 / 4.0
      sample bd, amp: bd_vol
    end
    sleep 0.5 / 4.0
  end
end

with_fx :hpf, cutoff: 60 do
  live_loop :cow do
    cue :base
    sample drumdir+"percussion/808-Conga"+(rand_i(5)+1).to_s+".wav", rate: 0.5, amp: conga_vol
    sleep [0.5,0.25].choose
  end
end

with_fx :reverb, mix: 0.5, room: 1.0,damp: 1.0 do
  with_fx :echo, phase: 2,mix: 0.2 do
    with_fx :panslicer, phase: 10, pan_min: -0.2, pan_max: 0.1, smooth: 1 do
      live_loop :buehne do
        cue :base
        sample buehne
        sleep 1000000
      end
    end
  end
end


#live_loop :guit do
#  cue :base
#  with_fx :reverb, room: 1.0 do
#    #use_random_seed 344235
#    with_fx :echo, phase: 1.3333, mix: 0.5 do
#      with_fx :ixi_techno, cutoff_min: 60, cutoff_max: 120 do
#        #use_random_seed 391239
#        use_random_seed 2
#        #use_random_seed 456457
#        12.times do
#          sample riff, num_slices: 32, slice: rand_i(32), rate: (1-2*rand_i(2))*1, pitch: -3, amp: guit_vol
#          sleep 1/3.0
#        end
#      end
#    end
#  end
#end