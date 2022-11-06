package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.components.data.StoppableAnimationLoaderVO;
   
   public class QuestRecruitWindowVO extends DAAPIDataClass
   {
      
      private static const BACK_ANIMATION_DATA:String = "backAnimationData";
       
      
      public var windowTitle:String = "";
      
      public var applyButtonLabel:String = "";
      
      public var cancelButtonLabel:String = "";
      
      public var name:String = "";
      
      public var nation:String = "";
      
      public var rank:String = "";
      
      public var backAnimationData:StoppableAnimationLoaderVO = null;
      
      public var bgImage:String = "";
      
      public var tankmanIcon:String = "";
      
      public function QuestRecruitWindowVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == BACK_ANIMATION_DATA && param2)
         {
            this.backAnimationData = new StoppableAnimationLoaderVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.backAnimationData != null)
         {
            this.backAnimationData.dispose();
            this.backAnimationData = null;
         }
         super.onDispose();
      }
   }
}
