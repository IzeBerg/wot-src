package net.wg.gui.lobby.battleResults.components
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.lobby.questsWindow.data.PersonalQuestConditionVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   
   public class PersonalQuestCondition extends Sprite implements IDisposable, IUpdatable
   {
       
      
      public var conditionTF:TextField;
      
      public var statusTF:TextField;
      
      private var _baseDisposed:Boolean = false;
      
      public function PersonalQuestCondition()
      {
         super();
         this.statusTF.autoSize = TextFieldAutoSize.RIGHT;
      }
      
      protected function onDispose() : void
      {
         this.conditionTF = this.statusTF = null;
      }
      
      public final function dispose() : void
      {
         if(this._baseDisposed)
         {
            return;
         }
         this.onDispose();
         this._baseDisposed = true;
      }
      
      public final function isDisposed() : Boolean
      {
         return this._baseDisposed;
      }
      
      public function update(param1:Object) : void
      {
         var _loc2_:PersonalQuestConditionVO = param1 as PersonalQuestConditionVO;
         if(_loc2_ == null)
         {
            return;
         }
         this.conditionTF.htmlText = _loc2_.text;
         this.statusTF.htmlText = _loc2_.statusText;
         App.utils.commons.updateTextFieldSize(this.conditionTF,false,true);
         App.utils.commons.updateTextFieldSize(this.statusTF,false,true);
      }
   }
}
