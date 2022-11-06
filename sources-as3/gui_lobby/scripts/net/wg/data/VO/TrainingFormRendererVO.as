package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   
   public class TrainingFormRendererVO extends DAAPIDataClass
   {
      
      private static const BADGE_FIELD_NAME:String = "badgeVisualVO";
       
      
      public var creatorIgrType:int = 0;
      
      public var creatorClan:String = "";
      
      public var creatorRegion:String = "";
      
      public var creatorName:String = "";
      
      public var comment:String = "";
      
      public var arena:String = "";
      
      public var count:Number = 0;
      
      public var total:Number = 0;
      
      public var owner:String = "";
      
      public var icon:String = "";
      
      public var disabled:Boolean;
      
      public var id:Number = 0;
      
      public var badgeVisualVO:BadgeVisualVO = null;
      
      public function TrainingFormRendererVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == BADGE_FIELD_NAME)
         {
            this.badgeVisualVO = new BadgeVisualVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.badgeVisualVO != null)
         {
            this.badgeVisualVO.dispose();
            this.badgeVisualVO = null;
         }
         super.onDispose();
      }
   }
}
