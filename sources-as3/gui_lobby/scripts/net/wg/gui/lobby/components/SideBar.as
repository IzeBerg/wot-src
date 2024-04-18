package net.wg.gui.lobby.components
{
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.events.Event;
   import net.wg.gui.components.advanced.ButtonBarEx;
   
   public class SideBar extends ButtonBarEx
   {
      
      private static const VERTICAL_OFFSET:int = 11;
      
      private static const ALPHA:Number = 0.4;
       
      
      public function SideBar()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         container.y = VERTICAL_OFFSET;
      }
      
      override protected function rescaleContainer() : void
      {
      }
      
      override protected function updateRenderers() : void
      {
         var _loc1_:Graphics = graphics;
         _loc1_.clear();
         super.updateRenderers();
         var _loc2_:DisplayObject = _renderers[_renderers.length - 1];
         if(_loc2_)
         {
            _loc1_.beginFill(0,ALPHA);
            _loc1_.drawRect(0,0,_loc2_.width,_loc2_.y + _loc2_.height + VERTICAL_OFFSET * 2);
            _width = _loc2_.width;
         }
         dispatchEvent(new Event(Event.RESIZE));
      }
   }
}
