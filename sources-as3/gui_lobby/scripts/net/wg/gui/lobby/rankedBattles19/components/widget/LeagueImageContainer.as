package net.wg.gui.lobby.rankedBattles19.components.widget
{
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.gui.lobby.rankedBattles19.components.ImageContainer;
   import scaleform.clik.constants.InvalidationType;
   
   public class LeagueImageContainer extends ImageContainer
   {
       
      
      public var hit:Sprite = null;
      
      public function LeagueImageContainer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         hitArea = this.hit;
         img.mouseEnabled = img.mouseChildren = false;
         img.addEventListener(Event.CHANGE,this.onImgChangeHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.hit.width = img.width;
            this.hit.height = img.height;
            this.hit.x = img.x;
            this.hit.y = img.y;
         }
      }
      
      override protected function onDispose() : void
      {
         img.removeEventListener(Event.CHANGE,this.onImgChangeHandler);
         this.hit = null;
         super.onDispose();
      }
      
      private function onImgChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
