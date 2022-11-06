package net.wg.gui.bootcamp.dialogs
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.meta.IBootcampDialogMeta;
   import net.wg.infrastructure.base.meta.impl.BootcampDialogMeta;
   
   public class BootcampDialog extends BootcampDialogMeta implements IBootcampDialogMeta
   {
      
      private static const TEXT_SPACE:int = 20;
      
      private static const ICON_SPACE:int = 3;
       
      
      public var labelField:TextField = null;
      
      public var icon:UILoaderAlt = null;
      
      public var awardIcon:MovieClip = null;
      
      public var awardField:TextField = null;
      
      public function BootcampDialog()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.labelField.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function layoutButtons(param1:Number) : void
      {
         var _loc3_:SoundButtonEx = null;
         var _loc2_:Vector.<SoundButtonEx> = getAllButtons();
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.visible)
            {
               _loc3_.y = param1;
            }
         }
      }
      
      override protected function applyLayout() : void
      {
         super.applyLayout();
         textField.y = this.labelField.y + this.labelField.textHeight + TEXT_SPACE;
      }
      
      override protected function getBackgroundActualHeight() : Number
      {
         return Math.max(this.icon.originalHeight + ICON_SPACE,super.getBackgroundActualHeight());
      }
      
      override protected function onDispose() : void
      {
         if(this.icon)
         {
            this.icon.dispose();
            this.icon = null;
         }
         this.labelField = null;
         this.awardIcon = null;
         this.awardField = null;
         super.onDispose();
      }
      
      public function as_setData(param1:String, param2:String, param3:Boolean, param4:String) : void
      {
         this.icon.source = param1;
         this.labelField.text = param2;
         this.awardIcon.visible = param3;
         if(param3)
         {
            this.awardField.text = param4;
         }
         invalidateLayout();
      }
   }
}
