package net.wg.gui.lobby.personalMissions.components.questAwardScreen
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.generated.MISSIONS_STATES;
   import net.wg.data.constants.generated.QUESTSPROGRESS;
   import net.wg.gui.components.questProgress.QuestProgressAtlasSprite;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class QuestStatus extends UIComponentEx
   {
      
      private static const GAP:int = -18;
      
      private static const INFO_OFFSET:int = 5;
       
      
      public var bg:Sprite = null;
      
      public var label:TextField;
      
      public var icon:QuestProgressAtlasSprite;
      
      private var _status:String;
      
      private var _statusLabel:String;
      
      public function QuestStatus()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.icon.isCentralize = true;
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(this._status != null && this._statusLabel != null && isInvalid(InvalidationType.DATA))
         {
            switch(this._status)
            {
               case MISSIONS_STATES.COMPLETED:
                  this.icon.imageName = QUESTSPROGRESS.QUEST_DONE;
                  break;
               case MISSIONS_STATES.FULL_COMPLETED:
                  this.icon.imageName = QUESTSPROGRESS.QUEST_DONE_PERFECTLY;
            }
            this.label.htmlText = this._statusLabel;
            _loc1_ = this.icon.width + GAP + this.label.textWidth;
            this.icon.x = (this.bg.width - _loc1_ >> 1) + INFO_OFFSET;
            this.label.x = this.icon.x + this.icon.width + GAP;
         }
      }
      
      override protected function onDispose() : void
      {
         this.bg = null;
         this.label = null;
         this.icon = null;
         super.onDispose();
      }
      
      public function setData(param1:String, param2:String) : void
      {
         this._status = param1;
         this._statusLabel = param2;
         invalidateData();
      }
   }
}
