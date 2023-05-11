package net.wg.gui.lobby.rankedBattles19.components.rankAward
{
   import flash.events.Event;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class RankContainer extends UIComponentEx
   {
       
      
      public var image:Image = null;
      
      public function RankContainer()
      {
         super();
         this.image.addEventListener(Event.CHANGE,this.onImageChangeHandler);
      }
      
      override protected function onDispose() : void
      {
         this.image.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.image.dispose();
         this.image = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.image.x = -this.image.width >> 1;
            this.image.y = -this.image.height >> 1;
         }
      }
      
      public function setState(param1:String) : void
      {
         gotoAndStop(param1);
      }
      
      public function set source(param1:String) : void
      {
         this.image.source = param1;
      }
      
      private function onImageChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
