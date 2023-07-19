package net.wg.gui.lobby.quests.components
{
   import flash.text.TextField;
   import net.wg.gui.lobby.quests.components.interfaces.ITasksProgressComponent;
   import net.wg.gui.lobby.quests.data.ChainProgressVO;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class BaseQuestsProgress extends UIComponentEx implements ITasksProgressComponent
   {
       
      
      private var _fields:Vector.<TextField>;
      
      public function BaseQuestsProgress()
      {
         this._fields = new Vector.<TextField>(0);
         super();
      }
      
      override protected function onDispose() : void
      {
         this._fields.splice(0,this._fields.length);
         this._fields = null;
         super.onDispose();
      }
      
      public function update(param1:Object) : void
      {
         var _loc2_:ChainProgressVO = ChainProgressVO(param1);
         var _loc3_:uint = _loc2_.progressItems.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._fields[_loc4_].htmlText = _loc2_.progressItems[_loc4_].value;
            _loc4_++;
         }
      }
      
      protected function addFields(... rest) : void
      {
         this._fields.push.apply(this._fields,rest);
      }
   }
}
