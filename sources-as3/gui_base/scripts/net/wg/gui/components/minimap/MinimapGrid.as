package net.wg.gui.components.minimap
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Linkages;
   import net.wg.infrastructure.base.meta.IMinimapGridMeta;
   import net.wg.infrastructure.base.meta.impl.MinimapGridMeta;
   import scaleform.gfx.MouseEventEx;
   
   public class MinimapGrid extends MinimapGridMeta implements IMinimapGridMeta
   {
      
      private static const CLICK_FINISHED:String = "ClickFinished";
       
      
      public var hitMc:MovieClip = null;
      
      public var icons:MovieClip = null;
      
      public var dices:MovieClip = null;
      
      public var back:MovieClip = null;
      
      private var _isClickEnabled:Boolean = true;
      
      public function MinimapGrid()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.hitMc.addEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
      }
      
      override protected function onDispose() : void
      {
         this.hitMc.removeEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         this.hitMc = null;
         while(this.icons.numChildren)
         {
            this.icons.removeChildAt(0).removeEventListener(CLICK_FINISHED,this.onClickFinishedHandler);
         }
         this.icons = null;
         this.dices = null;
         this.back = null;
         super.onDispose();
      }
      
      public function as_clickEnabled(param1:Boolean) : void
      {
         this._isClickEnabled = param1;
      }
      
      public function as_addPoint(param1:Number, param2:Number) : void
      {
         var _loc3_:MovieClip = App.utils.classFactory.getComponent(Linkages.MINIMAP_CLICK,MovieClip,{
            "x":param1,
            "y":param2,
            "scaleX":1,
            "scaleY":1
         });
         _loc3_.addEventListener(CLICK_FINISHED,this.onClickFinishedHandler);
         this.icons.addChild(_loc3_);
      }
      
      private function onClickFinishedHandler(param1:Event) : void
      {
         var _loc2_:MovieClip = MovieClip(param1.target);
         _loc2_.removeEventListener(CLICK_FINISHED,this.onClickFinishedHandler);
         this.icons.removeChild(_loc2_);
      }
      
      private function onMouseClickHandler(param1:MouseEvent) : void
      {
         if(MouseEventEx(param1).buttonIdx == MouseEventEx.LEFT_BUTTON)
         {
            if(this._isClickEnabled && !this.dices.visible)
            {
               setClickS(param1.localX,param1.localY);
            }
         }
      }
   }
}
