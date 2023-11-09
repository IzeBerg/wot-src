package net.wg.gui.lobby.sessionStats.settings
{
   import net.wg.gui.lobby.sessionStats.components.SessionStatsCheckboxRenderer;
   import net.wg.gui.lobby.sessionStats.data.SessionStatsSettingsBaseVO;
   import scaleform.clik.constants.InvalidationType;
   
   public class SessionStatsSettingsCommon extends SessionStatsSettingsBaseBlock
   {
       
      
      public var resetStatsCheckBox:SessionStatsCheckboxRenderer = null;
      
      public var saveTabCheckBox:SessionStatsCheckboxRenderer = null;
      
      private var _data:SessionStatsSettingsBaseVO = null;
      
      private var _inputs:Array = null;
      
      public function SessionStatsSettingsCommon()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._inputs = [this.resetStatsCheckBox,this.saveTabCheckBox];
      }
      
      override protected function onDispose() : void
      {
         this._inputs.splice(0,this._inputs.length);
         this._inputs = null;
         this.resetStatsCheckBox.dispose();
         this.resetStatsCheckBox = null;
         this.saveTabCheckBox.dispose();
         this.saveTabCheckBox = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            title.htmlText = this._data.title;
            _loc1_ = this._inputs.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this._inputs[_loc2_].update(this._data.inputs[_loc2_]);
               _loc2_++;
            }
         }
      }
      
      public function setData(param1:SessionStatsSettingsBaseVO) : void
      {
         this._data = param1;
         invalidateData();
      }
   }
}
