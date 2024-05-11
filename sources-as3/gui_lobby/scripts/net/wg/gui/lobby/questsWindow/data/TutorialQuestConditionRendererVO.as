package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TutorialQuestConditionRendererVO extends DAAPIDataClass
   {
       
      
      public var text:String = "";
      
      public var btnText:String = "";
      
      public var btnIcon:String = "";
      
      public var id:String = "";
      
      public var type:String = "";
      
      public function TutorialQuestConditionRendererVO(param1:Object)
      {
         super(param1);
      }
   }
}
