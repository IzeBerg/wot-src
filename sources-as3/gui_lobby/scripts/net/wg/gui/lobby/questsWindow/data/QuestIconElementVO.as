package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class QuestIconElementVO extends DAAPIDataClass
   {
       
      
      private var _label:String = "";
      
      private var _icon:String = "";
      
      private var _linkage:String = "QuestIconElement_UI";
      
      private var _dataType:String = "";
      
      private var _dataName:String = "";
      
      private var _dataBlock:String = "";
      
      private var _counter:String = "";
      
      private var _iconAutoSize:Boolean = true;
      
      public function QuestIconElementVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == "dataValue")
         {
            if(param2 is Array)
            {
               this.dataBlock = param2[0];
               this.dataName = param2[1];
            }
            return false;
         }
         return true;
      }
      
      public function get label() : String
      {
         return this._label;
      }
      
      public function set label(param1:String) : void
      {
         this._label = param1;
      }
      
      public function get icon() : String
      {
         return this._icon;
      }
      
      public function set icon(param1:String) : void
      {
         this._icon = param1;
      }
      
      public function get linkage() : String
      {
         return this._linkage;
      }
      
      public function set linkage(param1:String) : void
      {
         this._linkage = param1;
      }
      
      public function get dataType() : String
      {
         return this._dataType;
      }
      
      public function set dataType(param1:String) : void
      {
         this._dataType = param1;
      }
      
      public function get dataName() : String
      {
         return this._dataName;
      }
      
      public function set dataName(param1:String) : void
      {
         this._dataName = param1;
      }
      
      public function get dataBlock() : String
      {
         return this._dataBlock;
      }
      
      public function set dataBlock(param1:String) : void
      {
         this._dataBlock = param1;
      }
      
      public function get counter() : String
      {
         return this._counter;
      }
      
      public function set counter(param1:String) : void
      {
         this._counter = param1;
      }
      
      public function get iconAutoSize() : Boolean
      {
         return this._iconAutoSize;
      }
      
      public function set iconAutoSize(param1:Boolean) : void
      {
         this._iconAutoSize = param1;
      }
   }
}
