package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class InfoDataVO extends DAAPIDataClass
   {
       
      
      private var _descr:DescriptionVO = null;
      
      private var _subtasks:Array;
      
      private var _conditions:Array;
      
      public function InfoDataVO(param1:Object)
      {
         this._subtasks = [];
         this._conditions = [];
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         switch(param1)
         {
            case "descr":
               this._descr = Boolean(param2) ? new DescriptionVO(param2) : null;
               return false;
            default:
               return true;
         }
      }
      
      public function get descr() : DescriptionVO
      {
         return this._descr;
      }
      
      public function set descr(param1:DescriptionVO) : void
      {
         this._descr = param1;
      }
      
      public function get subtasks() : Array
      {
         return this._subtasks;
      }
      
      public function set subtasks(param1:Array) : void
      {
         this._subtasks = param1;
      }
      
      public function get conditions() : Array
      {
         return this._conditions;
      }
      
      public function set conditions(param1:Array) : void
      {
         this._conditions = param1;
      }
      
      override protected function onDispose() : void
      {
         if(this._descr)
         {
            this._descr.dispose();
            this._descr = null;
         }
         if(this._subtasks)
         {
            this._subtasks.splice(0,this._subtasks.length);
            this._subtasks = null;
         }
         if(this._conditions)
         {
            this._conditions.splice(0,this._conditions.length);
            this._conditions = null;
         }
         super.onDispose();
      }
   }
}
