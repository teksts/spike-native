class AddEmbedLinkToPlayAreas < ActiveRecord::Migration[7.0]
  def change
    add_column :play_areas, :embedLink, :string
    # Update captain_id for existing teams
    PlayArea.all.each do |playArea|
      # Set captain_id for each team. Just using the first player of a team.
      links = ['https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d166720.69967542592!2d-122.95311368575074!3d49.23828193350067!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x54867f24e780bc05%3A0xc828436e5100e4ee!2sRotary%20Centennial%20Beach%20Volleyball%20Courts%20(6)!5e0!3m2!1sen!2sca!4v1692045556052!5m2!1sen!2sca', 
        'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d166752.48105471488!2d-123.05954373946165!3d49.22886629665694!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x5485dbdb3563485d%3A0x2e54d5f14a69a3f5!2sVolleyball%20Courts!5e0!3m2!1sen!2sca!4v1692045617133!5m2!1sen!2sca',
        'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d166747.9407624939!2d-123.14400113692257!3d49.23021149751479!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x5486715381c97bad%3A0x9aaeffa12000003a!2sMahon%20Park%20Beach%20Volleyball%20Court!5e0!3m2!1sen!2sca!4v1692045672421!5m2!1sen!2sca',
        'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d166769.12906401663!2d-123.22090543379758!3d49.2239335801419!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x548674e580398cd3%3A0x831d6a83b8692802!2sMarpole%20Public%20Beach%20Volleyball%20Courts!5e0!3m2!1sen!2sca!4v1692045689102!5m2!1sen!2sca'] 
      link = links.sample      
      playArea.update(embedLink: link) if link
    end
  end
end
