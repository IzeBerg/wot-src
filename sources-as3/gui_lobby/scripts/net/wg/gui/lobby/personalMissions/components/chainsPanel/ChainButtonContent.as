package net.wg.gui.lobby.personalMissions.components.chainsPanel
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.advanced.interfaces.IProgressBarAnim;
   import net.wg.gui.components.advanced.vo.ProgressBarAnimVO;
   import net.wg.gui.lobby.personalMissions.components.interfaces.IChainButtonContent;
   import net.wg.gui.lobby.personalMissions.data.ChainButtonVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IImage;
   import scaleform.clik.constants.InvalidationType;
   
   public class ChainButtonContent extends UIComponentEx implements IChainButtonContent
   {
      
      private static const PM2_ICON_X:int = -10;
       
      
      public var tankIcon:IImage;
      
      public var progress:IProgressBarAnim;
      
      public var labelTF:TextField;
      
      public var progressTF:TextField;
      
      private var _data:ChainButtonVO = null;
      
      private var _progress:ProgressBarAnimVO = null;
      
      private const PM2_ICONS:Array = [RES_ICONS.MAPS_ICONS_PERSONALMISSIONS_ALLIANCES_CHAINBTN_ALLIANCE0,RES_ICONS.MAPS_ICONS_PERSONALMISSIONS_ALLIANCES_CHAINBTN_ALLIANCE1,RES_ICONS.MAPS_ICONS_PERSONALMISSIONS_ALLIANCES_CHAINBTN_ALLIANCE2,RES_ICONS.MAPS_ICONS_PERSONALMISSIONS_ALLIANCES_CHAINBTN_ALLIANCE3];
      
      public function ChainButtonContent()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.labelTF.htmlText = this._data.label;
               this.progressTF.htmlText = this._data.progressText;
               this.tankIcon.source = this._data.tankIcon;
               this.progress.setData(this._progress);
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this.tankIcon.x = this.PM2_ICONS.indexOf(this._data.tankIcon) >= 0 ? Number(PM2_ICON_X) : Number(0);
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.tankIcon.dispose();
         this.tankIcon = null;
         this.progress.dispose();
         this.progress = null;
         this.labelTF = null;
         this.progressTF = null;
         this._data = null;
         this._progress = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.labelTF.autoSize = this.progressTF.autoSize = TextFieldAutoSize.LEFT;
      }
      
      public function setFilters(param1:Array) : void
      {
         this.labelTF.filters = param1;
      }
      
      public function update(param1:Object) : void
      {
         this._data = ChainButtonVO(param1);
         this._progress = ProgressBarAnimVO(param1.progress);
         invalidateData();
      }
   }
}
