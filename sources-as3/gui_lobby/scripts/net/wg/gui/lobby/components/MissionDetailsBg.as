package net.wg.gui.lobby.components
{
   import flash.display.MovieClip;
   
   public class MissionDetailsBg extends BaseMissionDetailsBg
   {
       
      
      public var typeBg:MovieClip;
      
      public function MissionDetailsBg()
      {
         super();
      }
      
      override public function onDispose() : void
      {
         this.typeBg = null;
         super.onDispose();
      }
      
      public function setType(param1:String) : void
      {
         this.typeBg.gotoAndStop(param1);
      }
   }
}
