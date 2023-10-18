package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SubtaskVO extends DAAPIDataClass
   {
       
      
      private var _title:String = "";
      
      private var _questInfo:QuestRendererVO = null;
      
      public function SubtaskVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         switch(param1)
         {
            case "questInfo":
               this._questInfo = new QuestRendererVO(param2);
               return false;
            default:
               return true;
         }
      }
      
      public function get title() : String
      {
         return this._title;
      }
      
      public function set title(param1:String) : void
      {
         this._title = param1;
      }
      
      public function get questInfo() : QuestRendererVO
      {
         return this._questInfo;
      }
      
      public function set questInfo(param1:QuestRendererVO) : void
      {
         this._questInfo = param1;
      }
   }
}
