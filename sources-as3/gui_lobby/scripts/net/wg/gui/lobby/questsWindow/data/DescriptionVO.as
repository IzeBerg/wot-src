package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class DescriptionVO extends DAAPIDataClass
   {
       
      
      private var _title:String = "";
      
      private var _descr:String = "";
      
      public function DescriptionVO(param1:Object)
      {
         super(param1);
      }
      
      public function get title() : String
      {
         return this._title;
      }
      
      public function set title(param1:String) : void
      {
         this._title = param1;
      }
      
      public function get descr() : String
      {
         return this._descr;
      }
      
      public function set descr(param1:String) : void
      {
         this._descr = param1;
      }
   }
}
