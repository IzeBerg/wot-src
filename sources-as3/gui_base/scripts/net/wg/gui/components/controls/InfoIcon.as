package net.wg.gui.components.controls
{
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.constants.ToolTipShowType;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IInfoIcon;
   
   public class InfoIcon extends UIComponentEx implements IInfoIcon
   {
      
      public static const TYPE_INFO:String = "info";
      
      public static const TYPE_WARNING:String = "warning";
      
      public static const TYPE_ROBBED:String = "robbed";
      
      public static const TYPE_ATTENTION:String = "attention";
      
      public static const CHECK_BOX_MARGIN:Number = 10;
      
      public static const LABEL_MARGIN:Number = 10;
      
      private static const INV_ICON:String = "InvIcon";
       
      
      public var hit:MovieClip = null;
      
      private var _icoType:String = "info";
      
      private var _tooltip:String = "";
      
      public var tooltipType:ToolTipShowType;
      
      public function InfoIcon()
      {
         this.tooltipType = ToolTipShowType.COMPLEX;
         super();
         hitArea = this.hit;
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.MOUSE_OVER,this.onHitMouseOverHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onHitMouseOutHandler);
         removeEventListener(MouseEvent.CLICK,this.onHitClickHandler);
         this.hit = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.MOUSE_OVER,this.onHitMouseOverHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.onHitMouseOutHandler);
         addEventListener(MouseEvent.CLICK,this.onHitClickHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INV_ICON))
         {
            gotoAndStop(this.icoType);
         }
      }
      
      private function isIcoAvailable(param1:String) : Boolean
      {
         var _loc5_:FrameLabel = null;
         var _loc2_:Boolean = false;
         var _loc3_:uint = currentLabels.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = currentLabels[_loc4_];
            if(_loc5_.name == param1)
            {
               _loc2_ = true;
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function get icoType() : String
      {
         return this._icoType;
      }
      
      [Inspectable(defaultValue="info",name="icoType",type="list",enumeration="info,alert")]
      public function set icoType(param1:String) : void
      {
         if(param1 == this._icoType || !this.isIcoAvailable(param1))
         {
            return;
         }
         this._icoType = param1;
         invalidate(INV_ICON);
      }
      
      public function get tooltip() : String
      {
         return this._tooltip;
      }
      
      [Inspectable(defaultValue="",name="tooltip",type="String")]
      public function set tooltip(param1:String) : void
      {
         if(param1 == this._tooltip)
         {
            return;
         }
         this._tooltip = param1;
      }
      
      private function onHitMouseOverHandler(param1:MouseEvent) : void
      {
         if(this._tooltip && enabled)
         {
            if(this.tooltipType.value == ToolTipShowType.COMPLEX.value)
            {
               App.toolTipMgr.showComplex(this._tooltip);
            }
            else if(this.tooltipType.value == ToolTipShowType.SPECIAL.value)
            {
               App.toolTipMgr.showSpecial(this._tooltip,null);
            }
         }
      }
      
      private function onHitMouseOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onHitClickHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      override protected function handleStageChange(param1:Event) : void
      {
         if(param1.type == Event.ADDED_TO_STAGE)
         {
            removeEventListener(Event.ADDED_TO_STAGE,this.handleStageChange,false);
            addEventListener(Event.ENTER_FRAME,handleEnterFrameValidation,false,0,true);
            addEventListener(Event.RENDER,validateNow,false,0,true);
            if(stage != null)
            {
               stage.invalidate();
            }
         }
      }
   }
}
