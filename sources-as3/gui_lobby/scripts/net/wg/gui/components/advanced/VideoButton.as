package net.wg.gui.components.advanced
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.common.FrameStateCmpnt;
   import net.wg.infrastructure.base.UIComponentEx;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.MouseEventEx;
   
   public class VideoButton extends UIComponentEx
   {
      
      public static const SIZE_ID_BIG:String = "sizeBigID";
      
      public static const SIZE_ID_SMALL:String = "sizeSmallID";
      
      private static const INV_SIZE_ID:String = "invalidateSizeID";
      
      private static const OVER_ALPHA:Number = 0.9;
       
      
      public var bg:FrameStateCmpnt = null;
      
      public var hitMc:FrameStateCmpnt = null;
      
      private var _sizeID:String = "";
      
      public function VideoButton()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseChildren = false;
         buttonMode = true;
         useHandCursor = true;
         this.hitArea = this.hitMc;
         if(StringUtils.isEmpty(this._sizeID))
         {
            this.sizeID = SIZE_ID_BIG;
         }
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         addEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         removeEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         this.hitArea = null;
         this.hitMc.dispose();
         this.hitMc = null;
         this.bg.dispose();
         this.bg = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INV_SIZE_ID) && StringUtils.isNotEmpty(this._sizeID))
         {
            this.bg.frameLabel = this._sizeID;
            this.hitMc.frameLabel = this._sizeID;
            this.width = this.bg.actualWidth;
            this.height = this.bg.actualHeight;
            dispatchEvent(new Event(Event.RESIZE,true));
         }
      }
      
      public function set sizeID(param1:String) : void
      {
         if(this._sizeID == param1)
         {
            return;
         }
         this._sizeID = param1;
         invalidate(INV_SIZE_ID);
      }
      
      private function onMouseClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.mouseIdx);
         var _loc4_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.buttonIdx);
         if(_loc4_ != MouseEventEx.LEFT_BUTTON)
         {
            return;
         }
         var _loc5_:ButtonEvent = new ButtonEvent(ButtonEvent.CLICK,true,false,_loc3_,_loc4_,false,false);
         dispatchEvent(_loc5_);
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         this.alpha = Values.DEFAULT_ALPHA;
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         this.alpha = OVER_ALPHA;
      }
   }
}
