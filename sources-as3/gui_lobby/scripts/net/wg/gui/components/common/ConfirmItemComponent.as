package net.wg.gui.components.common
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.components.controls.ActionPrice;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.NumericStepper;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.constants.InvalidationType;
   
   public class ConfirmItemComponent extends UIComponentEx
   {
      
      private static const ITEM_ICON_LEFT:int = 12;
      
      private static const ITEM_ICON_TOP:int = 13;
      
      private static const TF_OFFSET:int = 4;
      
      private static const CONTENT_WIDTH:int = 398;
       
      
      public var submitBtn:SoundButtonEx = null;
      
      public var cancelBtn:SoundButtonEx = null;
      
      public var leftResultIT:IconText = null;
      
      public var rightResultIT:IconText = null;
      
      public var countLabel:TextField = null;
      
      public var leftLabel:TextField = null;
      
      public var resultLabel:TextField = null;
      
      public var rightLabel:TextField = null;
      
      public var leftIT:IconText = null;
      
      public var rightIT:IconText = null;
      
      public var actionPrice:ActionPrice = null;
      
      public var nsCount:NumericStepper = null;
      
      public var description:TextField = null;
      
      public var moduleName:TextField = null;
      
      public var itemIcon:IDisposable = null;
      
      public var dropdownMenu:DropdownMenu = null;
      
      public function ConfirmItemComponent()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this.submitBtn != null)
         {
            this.submitBtn.dispose();
            this.submitBtn = null;
         }
         if(this.cancelBtn != null)
         {
            this.cancelBtn.dispose();
            this.cancelBtn = null;
         }
         if(this.leftResultIT != null)
         {
            this.leftResultIT.dispose();
            this.leftResultIT = null;
         }
         if(this.rightResultIT != null)
         {
            this.rightResultIT.dispose();
            this.rightResultIT = null;
         }
         if(this.actionPrice != null)
         {
            this.actionPrice.dispose();
            this.actionPrice = null;
         }
         if(this.nsCount != null)
         {
            this.nsCount.dispose();
            this.nsCount = null;
         }
         if(this.rightIT != null)
         {
            this.rightIT.dispose();
            this.rightIT = null;
         }
         if(this.leftIT != null)
         {
            this.leftIT.dispose();
            this.leftIT = null;
         }
         if(this.dropdownMenu != null)
         {
            this.dropdownMenu.dispose();
            this.dropdownMenu = null;
         }
         this.tryClearItemIcon();
         this.countLabel = null;
         this.leftLabel = null;
         this.resultLabel = null;
         this.rightLabel = null;
         this.description = null;
         this.moduleName = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.layoutTexts();
         }
      }
      
      public function setIcon(param1:DisplayObject, param2:Boolean = false) : void
      {
         this.tryClearItemIcon();
         param1.x = ITEM_ICON_LEFT;
         param1.y = ITEM_ICON_TOP;
         this.itemIcon = IDisposable(param1);
         addChild(param1);
         if(param2)
         {
            invalidateSize();
         }
      }
      
      private function layoutTexts() : void
      {
         var _loc1_:Sprite = Sprite(this.itemIcon);
         this.moduleName.x = this.description.x = _loc1_.x + _loc1_.width + TF_OFFSET;
         this.moduleName.width = this.description.width = CONTENT_WIDTH - this.moduleName.x - TF_OFFSET;
      }
      
      private function tryClearItemIcon() : void
      {
         if(this.itemIcon != null)
         {
            this.itemIcon.dispose();
            this.itemIcon = null;
         }
      }
   }
}
