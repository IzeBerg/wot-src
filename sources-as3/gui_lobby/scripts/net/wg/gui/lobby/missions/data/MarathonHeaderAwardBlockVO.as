package net.wg.gui.lobby.missions.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.paginator.vo.ToolTipVO;
   import net.wg.gui.lobby.components.data.AwardItemRendererExVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.data.DataProvider;
   
   public class MarathonHeaderAwardBlockVO extends DAAPIDataClass
   {
      
      public static const AWARDS_DATA_FIELD:String = "awardsData";
      
      public static const AWARD_IMG_TOOLTIP_FIELD:String = "awardImgTooltip";
       
      
      public var title:String = "";
      
      public var awardImgSource:String = "";
      
      private var _awardsData:DataProvider = null;
      
      private var _awardImgTooltip:ToolTipVO = null;
      
      public function MarathonHeaderAwardBlockVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == AWARDS_DATA_FIELD)
         {
            this._awardsData = new DataProvider();
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,Errors.INVALID_TYPE + Array);
            for each(_loc4_ in _loc3_)
            {
               this._awardsData.push(new AwardItemRendererExVO(_loc4_));
            }
            return false;
         }
         if(param1 == AWARD_IMG_TOOLTIP_FIELD)
         {
            this._awardImgTooltip = new ToolTipVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this._awardsData)
         {
            _loc1_.dispose();
         }
         this._awardsData.cleanUp();
         this._awardsData = null;
         this._awardImgTooltip.dispose();
         this._awardImgTooltip = null;
         super.onDispose();
      }
      
      public function hasAwardImg() : Boolean
      {
         return StringUtils.isNotEmpty(this.awardImgSource);
      }
      
      public function get awardsData() : DataProvider
      {
         return this._awardsData;
      }
      
      public function get awardImgTooltip() : ToolTipVO
      {
         return this._awardImgTooltip;
      }
   }
}
