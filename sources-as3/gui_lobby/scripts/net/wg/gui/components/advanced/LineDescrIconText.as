package net.wg.gui.components.advanced
{
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.managers.IToolTipParams;
   import scaleform.clik.constants.InvalidationType;
   
   public class LineDescrIconText extends LineIconText
   {
      
      public static const DESCRIPTION_TEXT_INVALID:String = "dInvalid";
      
      public static const TOOLTIP_INVALID:String = "tooltipInvalid";
       
      
      public var textField:TextField;
      
      private var _myEnabled:Boolean = true;
      
      private var _isToolTipShowing:Boolean;
      
      private var hitSprite:Sprite;
      
      private var _description:String = "";
      
      private var _tooltip:String = null;
      
      private var _tooltipParams:IToolTipParams = null;
      
      public function LineDescrIconText()
      {
         this.hitSprite = new Sprite();
         super();
      }
      
      private static function hideToolTip() : void
      {
         App.toolTipMgr.hide();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:Graphics = this.hitSprite.graphics;
         _loc1_.beginFill(1,0);
         _loc1_.drawRect(0,0,1,1);
         _loc1_.endFill();
         addChild(this.hitSprite);
         this.hitSprite.name = "hitSprite";
         this.hitArea = this.hitSprite;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(DESCRIPTION_TEXT_INVALID))
         {
            this.textField.multiline = true;
            this.textField.mouseEnabled = false;
            this.textField.text = this._description;
            invalidateSize();
            dispatchEvent(new Event(Event.RESIZE,true));
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.resizeHitSprite();
         }
         if(isInvalid(TOOLTIP_INVALID))
         {
            this.refreshTooltip();
         }
      }
      
      protected function resizeHitSprite() : void
      {
         this.hitSprite.width = this.width;
         this.hitSprite.height = this.textField.y + this.textField.textHeight;
      }
      
      override protected function applyText(param1:String) : void
      {
         if(this._myEnabled)
         {
            gotoAndPlay("up");
            super.applyText(param1);
            textComponent.textField.alpha = 1;
         }
         else
         {
            gotoAndPlay("disabled");
            super.applyText("--");
            textComponent.textField.alpha = 0.2;
         }
         invalidateSize();
         invalidate(DESCRIPTION_TEXT_INVALID);
      }
      
      override protected function onDispose() : void
      {
         this.disposeHandlers();
         this._tooltipParams = null;
         super.onDispose();
      }
      
      protected function showToolTip(param1:IToolTipParams) : void
      {
         if(this._tooltip)
         {
            if(this._tooltipParams == null)
            {
               App.toolTipMgr.showComplex(this._tooltip);
            }
            else
            {
               App.toolTipMgr.showComplexWithParams(this._tooltip,this._tooltipParams);
            }
         }
      }
      
      private function disposeHandlers() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHandler);
      }
      
      private function refreshTooltip() : void
      {
         this.disposeHandlers();
         if(this._isToolTipShowing)
         {
            hideToolTip();
            this.showToolTip(null);
         }
         if(this._tooltip)
         {
            addEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler,false,0,true);
            addEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHandler,false,0,true);
         }
      }
      
      override public function get width() : Number
      {
         return this.textField.x + this.textField.width;
      }
      
      [Inspectable(defaultValue="true")]
      override public function get enabled() : Boolean
      {
         return this._myEnabled;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(param1 != this._myEnabled)
         {
            this._myEnabled = param1;
            invalidate(TEXT_INVALID);
         }
      }
      
      [Inspectable(type="String")]
      public function get description() : String
      {
         return this._description;
      }
      
      public function set description(param1:String) : void
      {
         if(this._description != param1)
         {
            this._description = param1;
            invalidate(DESCRIPTION_TEXT_INVALID);
         }
      }
      
      public function get tooltip() : String
      {
         return this._tooltip;
      }
      
      public function set tooltip(param1:String) : void
      {
         this._tooltip = param1;
         invalidate(TOOLTIP_INVALID);
      }
      
      public function get tooltipParams() : IToolTipParams
      {
         return this._tooltipParams;
      }
      
      public function set tooltipParams(param1:IToolTipParams) : void
      {
         this._tooltipParams = param1;
         invalidate(TOOLTIP_INVALID);
      }
      
      protected function mouseRollOverHandler(param1:MouseEvent) : void
      {
         this._isToolTipShowing = true;
         this.showToolTip(null);
      }
      
      protected function mouseRollOutHandler(param1:MouseEvent) : void
      {
         this._isToolTipShowing = false;
         hideToolTip();
      }
   }
}
