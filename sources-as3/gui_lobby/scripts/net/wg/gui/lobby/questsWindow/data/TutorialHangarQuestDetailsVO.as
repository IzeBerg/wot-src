package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TutorialHangarQuestDetailsVO extends DAAPIDataClass
   {
      
      private static const DESC_FIELD_NAME:String = "description";
       
      
      public var title:String = "";
      
      public var image:String = "";
      
      public var infoList:Array;
      
      public var awards:Array;
      
      public var description:TutorialQuestDescVO;
      
      public function TutorialHangarQuestDetailsVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         switch(param1)
         {
            case DESC_FIELD_NAME:
               this.description = new TutorialQuestDescVO(param2);
               return false;
            default:
               return super.onDataWrite(param1,param2);
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.awards != null)
         {
            _loc2_ = this.awards.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               this.awards[_loc1_] = null;
               _loc1_++;
            }
            this.awards.splice(0,_loc2_);
            this.awards = null;
         }
         if(this.infoList != null)
         {
            _loc2_ = this.infoList.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               this.infoList[_loc1_] = null;
               _loc1_++;
            }
            this.infoList.splice(0,_loc2_);
            this.infoList = null;
         }
         if(this.description != null)
         {
            this.description.dispose();
            this.description = null;
         }
         super.onDispose();
      }
   }
}
