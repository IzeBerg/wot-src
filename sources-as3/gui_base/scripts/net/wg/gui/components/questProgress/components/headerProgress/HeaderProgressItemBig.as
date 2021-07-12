package net.wg.gui.components.questProgress.components.headerProgress
{
   import flash.display.Sprite;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.questProgress.interfaces.data.IHeaderProgressData;
   
   public class HeaderProgressItemBig extends HeaderProgressItemProgress
   {
      
      private static const SEPARATOR_GAP:int = 9;
      
      private static const HEADER_TF_GAP:int = 11;
      
      private static const CONDITION_ICON_WIDTH:int = 22;
      
      private static const CONDITION_ICON_GAP:int = 4;
      
      private static const CONDITION_ICON_START_X:int = -34;
       
      
      public var conditionIcon:UILoaderAlt = null;
      
      public var separator:Sprite = null;
      
      public function HeaderProgressItemBig()
      {
         super();
      }
      
      override protected function onDataUpdate(param1:IHeaderProgressData, param2:int) : void
      {
         var _loc3_:int = 0;
         super.onDataUpdate(param1,param2);
         this.conditionIcon.source = param1.conditionIcon;
         App.utils.commons.updateTextFieldSize(headerTf,true,false);
         _loc3_ = valueTitleTf.width + headerTf.width + SEPARATOR_GAP + HEADER_TF_GAP + CONDITION_ICON_WIDTH + CONDITION_ICON_GAP;
         if(_loc3_ < param2)
         {
            this.conditionIcon.x = (param2 - _loc3_ >> 1) + CONDITION_ICON_START_X;
         }
         else
         {
            this.conditionIcon.x = CONDITION_ICON_START_X;
         }
         valueTitleTf.x = this.conditionIcon.x - CONDITION_ICON_START_X + CONDITION_ICON_WIDTH + CONDITION_ICON_GAP;
         this.separator.x = valueTitleTf.x + valueTitleTf.width + SEPARATOR_GAP;
         headerTf.x = this.separator.x + HEADER_TF_GAP;
         if(_loc3_ > param2)
         {
            headerTf.width = param2 - headerTf.x;
            truncatHeaderTf();
         }
      }
      
      override protected function onDispose() : void
      {
         this.conditionIcon.dispose();
         this.conditionIcon = null;
         this.separator = null;
         super.onDispose();
      }
   }
}
