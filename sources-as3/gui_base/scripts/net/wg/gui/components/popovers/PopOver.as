package net.wg.gui.components.popovers
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.CloseButton;
   import net.wg.infrastructure.base.BaseViewWrapper;
   import net.wg.infrastructure.interfaces.IAbstractWrapperView;
   import net.wg.infrastructure.interfaces.IPopoverWrapper;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.ComponentEvent;
   
   public class PopOver extends BaseViewWrapper implements IPopoverWrapper
   {
      
      private static const ARROW_DIRECTION_INV:String = "arrowDirectionInvalid";
      
      private static const ARROW_POSITION_INV:String = "arrowPositionInvalid";
      
      private static const CLOSE_BTN_VISIBLE_INV:String = "arrowPositionInvalid";
      
      public static const GlowArrowBottom_UI:String = "GlowArrowBottom_UI";
      
      public static const GlowArrowLeft_UI:String = "GlowArrowLeft_UI";
      
      public static const GlowArrowRight_UI:String = "GlowArrowRight_UI";
      
      public static const GlowArrowTop_UI:String = "GlowArrowTop_UI";
      
      private static const TITLE_INVALID:String = "titleInv";
       
      
      protected var _arrowDirection:int = -1;
      
      protected var _arrowPosition:int = 0;
      
      private var _title:String = "";
      
      public var titleTextField:TextField;
      
      public var closeBtn:CloseButton;
      
      public var background:MovieClip;
      
      public var hitMc:MovieClip;
      
      public var arrowLeft:MovieClip;
      
      public var arrowRight:MovieClip;
      
      public var arrowTop:MovieClip;
      
      public var arrowBottom:MovieClip;
      
      private var _isCloseBtnVisible:Boolean = false;
      
      public function PopOver()
      {
         super();
         this.setArrowVisible(PopOverConst.ARROW_NONE);
         this.initLayout();
      }
      
      protected function initLayout() : void
      {
         layout = new PopoverInternalLayout();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.titleTextField.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function draw() : void
      {
         super.draw();
         this.mouseEnabled = false;
         if(isInvalid(TITLE_INVALID))
         {
            this.titleTextField.text = this._title || "";
         }
         if(isInvalid(ARROW_DIRECTION_INV))
         {
            this.applyArrowDirectionChanges();
            invalidate(ARROW_POSITION_INV);
         }
         if(isInvalid(ARROW_POSITION_INV))
         {
            this.applyArrowPositionChanges();
         }
         if(isInvalid(CLOSE_BTN_VISIBLE_INV))
         {
            this.closeBtn.visible = this._isCloseBtnVisible;
            if(this._isCloseBtnVisible)
            {
               this.closeBtn.addEventListener(ButtonEvent.CLICK,this.closeBtnClickHandler,false,0,true);
               this.closeBtn.toggle = false;
            }
            else
            {
               this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.closeBtnClickHandler);
            }
         }
      }
      
      private function closeBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new ComponentEvent(ComponentEvent.HIDE));
      }
      
      private function setArrowVisible(param1:int) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc2_:Vector.<DisplayObject> = this.getArrowsList();
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc4_];
            _loc3_.visible = _loc4_ == param1;
            _loc4_++;
         }
      }
      
      override public function set wrapperContent(param1:IAbstractWrapperView) : void
      {
         super.wrapperContent = param1;
         addChild(this.closeBtn);
      }
      
      protected function applyArrowDirectionChanges() : void
      {
         this.setArrowVisible(this._arrowDirection);
      }
      
      protected function applyArrowPositionChanges() : void
      {
         invalidateLayout();
      }
      
      public function getArrowsList() : Vector.<DisplayObject>
      {
         var _loc1_:Vector.<DisplayObject> = new Vector.<DisplayObject>(4);
         _loc1_[PopOverConst.ARROW_RIGHT] = this.arrowRight;
         _loc1_[PopOverConst.ARROW_TOP] = this.arrowTop;
         _loc1_[PopOverConst.ARROW_BOTTOM] = this.arrowBottom;
         _loc1_[PopOverConst.ARROW_LEFT] = this.arrowLeft;
         return _loc1_;
      }
      
      public function get arrowDirection() : uint
      {
         return this._arrowDirection;
      }
      
      public function set arrowDirection(param1:uint) : void
      {
         if(this._arrowDirection != param1)
         {
            this._arrowDirection = param1;
            invalidate(ARROW_DIRECTION_INV);
         }
      }
      
      public function get arrowPosition() : int
      {
         return this._arrowPosition;
      }
      
      public function set arrowPosition(param1:int) : void
      {
         if(this._arrowPosition != param1)
         {
            this._arrowPosition = param1;
            invalidate(ARROW_POSITION_INV);
         }
      }
      
      public function get title() : String
      {
         return this._title;
      }
      
      public function set title(param1:String) : void
      {
         this._title = param1;
         invalidate(TITLE_INVALID);
      }
      
      override public function get width() : Number
      {
         return this.hitMc.width;
      }
      
      public function get hitAreaTopLeftPaddings() : Point
      {
         return new Point(this.hitMc.x,this.hitMc.y);
      }
      
      override public function get height() : Number
      {
         return this.hitMc.height;
      }
      
      override protected function onDispose() : void
      {
         this.titleTextField = null;
         this.background = null;
         this.hitMc = null;
         this.arrowLeft = null;
         this.arrowRight = null;
         this.arrowTop = null;
         this.arrowBottom = null;
         this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.closeBtnClickHandler);
         this.closeBtn = null;
         super.onDispose();
      }
      
      public function get isCloseBtnVisible() : Boolean
      {
         return this._isCloseBtnVisible;
      }
      
      public function set isCloseBtnVisible(param1:Boolean) : void
      {
         if(this._isCloseBtnVisible != param1)
         {
            this._isCloseBtnVisible = param1;
            invalidate(CLOSE_BTN_VISIBLE_INV,InvalidationType.LAYOUT);
         }
      }
   }
}
