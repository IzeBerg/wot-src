package net.wg.gui.lobby.window
{
   import net.wg.gui.lobby.rankedBattles19.components.RankedBattlesPageHeader;
   import net.wg.gui.lobby.rankedBattles19.components.RankedBattlesPageHeaderHelper;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesPageHeaderVO;
   import net.wg.infrastructure.base.meta.IRankedPrimeTimeMeta;
   import net.wg.infrastructure.base.meta.impl.RankedPrimeTimeMeta;
   import net.wg.utils.IStageSizeDependComponent;
   import scaleform.clik.constants.InvalidationType;
   
   public class RankedPrimeTime extends RankedPrimeTimeMeta implements IRankedPrimeTimeMeta, IStageSizeDependComponent
   {
       
      
      public var header:RankedBattlesPageHeader = null;
      
      private var _headerHelper:RankedBattlesPageHeaderHelper = null;
      
      private var _headerSizeId:String = "small";
      
      private const SERVER_LABEL_FIELD:String = "shortname";
      
      public function RankedPrimeTime()
      {
         super();
         this._headerHelper = RankedBattlesPageHeaderHelper.getInstance();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         serversDD.labelField = this.SERVER_LABEL_FIELD;
         App.stageSizeMgr.register(this);
      }
      
      override protected function onDispose() : void
      {
         this.header.dispose();
         this.header = null;
         this._headerHelper = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.header.x = width - this.header.width >> 1;
            this.header.setSizeId(this._headerSizeId);
            this.header.y = this._headerHelper.getYOffset(this._headerSizeId);
            closeBtn.y = this.header.y + this._headerHelper.getCloseBtnYOffset(this._headerSizeId);
         }
      }
      
      override protected function setHeaderData(param1:RankedBattlesPageHeaderVO) : void
      {
         this.header.setData(param1);
         invalidateSize();
      }
      
      public function as_setBackgroundSource(param1:String) : void
      {
         setBackground(param1);
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         this._headerSizeId = this._headerHelper.getSizeId(param1,param2);
         invalidateSize();
      }
   }
}
