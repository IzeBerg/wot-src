package net.wg.gui.lobby.profile.components
{
   import scaleform.clik.controls.Button;
   
   public class TestTrack extends Button
   {
       
      
      public function TestTrack()
      {
         super();
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
      }
      
      [Inspectable(defaultValue="true")]
      override public function get visible() : Boolean
      {
         return super.visible;
      }
   }
}
