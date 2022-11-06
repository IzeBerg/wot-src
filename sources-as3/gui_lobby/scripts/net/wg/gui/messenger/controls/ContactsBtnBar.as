package net.wg.gui.messenger.controls
{
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class ContactsBtnBar extends UIComponentEx
   {
      
      private static const OK_VISIBLE_INV:String = "okVisInv";
      
      private static const BTN_PADDING_INV:String = "btnsPadInv";
       
      
      public var btnOk:SoundButtonEx;
      
      public var btnCancel:SoundButtonEx;
      
      public var bg:MovieClip;
      
      public var hit:MovieClip;
      
      private var isOkButtonVisible:Boolean = true;
      
      private var _verricalBtnsPadding:uint = 10;
      
      public function ContactsBtnBar()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         hitArea = this.hit;
         this.bg.mouseEnabled = this.bg.mouseChildren = false;
      }
      
      override protected function draw() : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         super.draw();
         var _loc1_:Boolean = isInvalid(OK_VISIBLE_INV);
         if(_loc1_)
         {
            this.btnOk.visible = this.isOkButtonVisible;
         }
         if(_loc1_ || isInvalid(InvalidationType.SIZE))
         {
            _loc2_ = 10;
            this.bg.width = _width;
            _loc3_ = !!this.isOkButtonVisible ? uint(this.btnOk.width + _loc2_) : uint(0);
            _loc4_ = _width - _loc3_ - this.btnCancel.width >> 1;
            this.btnOk.x = _loc4_;
            this.btnCancel.x = _loc4_ + _loc3_;
         }
         if(isInvalid(BTN_PADDING_INV))
         {
            this.btnOk.y = this.btnCancel.y = this._verricalBtnsPadding;
         }
      }
      
      override protected function onDispose() : void
      {
         this.btnOk.dispose();
         this.btnOk = null;
         this.btnCancel.dispose();
         this.btnCancel = null;
         this.bg = null;
         this.hit = null;
         super.onDispose();
      }
      
      public function getActualBtnsHeight() : uint
      {
         return this.btnOk.height;
      }
      
      public function showOkButton(param1:Boolean) : void
      {
         this.isOkButtonVisible = param1;
         invalidate(OK_VISIBLE_INV);
      }
      
      public function get verricalBtnsPadding() : uint
      {
         return this._verricalBtnsPadding;
      }
      
      public function set verricalBtnsPadding(param1:uint) : void
      {
         if(this._verricalBtnsPadding != param1)
         {
            this._verricalBtnsPadding = param1;
            invalidate(BTN_PADDING_INV);
         }
      }
   }
}
