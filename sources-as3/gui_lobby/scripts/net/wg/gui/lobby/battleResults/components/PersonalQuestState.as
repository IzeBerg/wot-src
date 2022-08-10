package net.wg.gui.lobby.battleResults.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.lobby.questsWindow.data.StateVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.constants.InvalidationType;
   
   public class PersonalQuestState extends UIComponentEx implements IUpdatable
   {
      
      private static const ICON_GAP:int = -8;
       
      
      public var textField:TextField;
      
      public var icon:MovieClip;
      
      private var _data:StateVO = null;
      
      public function PersonalQuestState()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.textField.htmlText = this._data.statusText;
            this.icon.gotoAndStop(this._data.statusState);
            this.icon.x = width - this.textField.textWidth - this.icon.width - ICON_GAP;
         }
      }
      
      override protected function onDispose() : void
      {
         this.textField = null;
         this.icon = null;
         this._data = null;
         super.onDispose();
      }
      
      public function update(param1:Object) : void
      {
         if(this._data != param1 && param1 != null)
         {
            this._data = StateVO(param1);
            invalidateData();
         }
      }
   }
}
