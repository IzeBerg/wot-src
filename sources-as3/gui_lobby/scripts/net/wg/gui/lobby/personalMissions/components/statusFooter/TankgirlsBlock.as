package net.wg.gui.lobby.personalMissions.components.statusFooter
{
   import flash.text.TextField;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.lobby.personalMissions.data.TankgirlsBlockVO;
   import net.wg.infrastructure.interfaces.entity.ISoundable;
   import scaleform.clik.constants.InvalidationType;
   
   public class TankgirlsBlock extends BasicFooterBlock implements ISoundable
   {
       
      
      public var counterTf:TextField = null;
      
      private var _data:TankgirlsBlockVO = null;
      
      public function TankgirlsBlock()
      {
         super();
      }
      
      override public function update(param1:Object) : void
      {
         this._data = TankgirlsBlockVO(param1);
         super.update(param1);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.soundMgr.addSoundsHdlrs(this);
         visible = false;
         icon.source = RES_ICONS.MAPS_ICONS_QUESTS_BONUSES_BIG_TANKWOMAN;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.counterTf.htmlText = this._data.counterText;
            visible = this._data.visible;
            invalidateSize();
         }
      }
      
      override protected function onDispose() : void
      {
         this.counterTf = null;
         this._data = null;
         super.onDispose();
      }
      
      public function canPlaySound(param1:String) : Boolean
      {
         return true;
      }
      
      public function getSoundId() : String
      {
         return "";
      }
      
      public function getSoundType() : String
      {
         return SoundTypes.WOMAN_LIST_POPOVER;
      }
      
      override public function get width() : Number
      {
         return hoverMc.width;
      }
   }
}
