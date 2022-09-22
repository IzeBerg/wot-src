package net.wg.gui.lobby.badges.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   
   public class BadgeVO extends DAAPIDataClass
   {
      
      private static const VISUAL_FIELD_NAME:String = "visual";
       
      
      public var id:int = -1;
      
      public var title:String = "";
      
      public var description:String = "";
      
      public var enabled:Boolean = true;
      
      public var selected:Boolean = false;
      
      public var tooltip:String = "";
      
      public var highlightIcon:String = "";
      
      public var isFirstLook:Boolean = false;
      
      public var visual:BadgeVisualVO = null;
      
      public function BadgeVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == VISUAL_FIELD_NAME)
         {
            this.visual = new BadgeVisualVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.visual.dispose();
         this.visual = null;
         super.onDispose();
      }
   }
}
