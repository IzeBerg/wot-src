package net.wg.gui.lobby.missions.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.paginator.vo.ToolTipVO;
   import net.wg.gui.lobby.components.data.AwardItemRendererExVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class MissionCardViewVO extends DAAPIDataClass
   {
      
      private static const BATTLE_CONDITIONS:String = "battleConditions";
      
      private static const TOKEN_CONDITIONS:String = "tokenConditions";
      
      private static const AWARDS:String = "awards";
      
      private static const STATUS_TOOLTIP_DATA:String = "statusTooltipData";
       
      
      public var status:String = "";
      
      public var blockID:String = "";
      
      public var eventID:String = "";
      
      public var title:String = "";
      
      public var statusLabel:String = "";
      
      public var background:String = "";
      
      public var tokenConditions:DataProvider = null;
      
      public var awards:DataProvider = null;
      
      public var isAvailable:Boolean = true;
      
      public var uiDecoration:String = "";
      
      private var _statusTooltipData:ToolTipVO = null;
      
      private var _battleConditions:Vector.<MissionConditionsContainerVO>;
      
      public function MissionCardViewVO(param1:Object)
      {
         this._battleConditions = new Vector.<MissionConditionsContainerVO>();
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         if(param1 == BATTLE_CONDITIONS)
         {
            _loc4_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc4_,BATTLE_CONDITIONS + Errors.INVALID_TYPE + Array);
            for each(_loc3_ in _loc4_)
            {
               this._battleConditions.push(new MissionConditionsContainerVO(_loc3_));
            }
            return false;
         }
         if(param1 == TOKEN_CONDITIONS)
         {
            _loc4_ = param2 as Array;
            App.utils.asserter.assertNotNull(param2 is Array,Errors.INVALID_TYPE + "Array");
            this.tokenConditions = new DataProvider();
            for each(_loc3_ in _loc4_)
            {
               this.tokenConditions.push(new TokenRendererVO(_loc3_));
            }
            return false;
         }
         if(param1 == AWARDS)
         {
            _loc4_ = param2 as Array;
            App.utils.asserter.assertNotNull(param2 is Array,Errors.INVALID_TYPE + "Array");
            this.awards = new DataProvider();
            for each(_loc3_ in _loc4_)
            {
               this.awards.push(new AwardItemRendererExVO(_loc3_));
            }
            return false;
         }
         if(param1 == STATUS_TOOLTIP_DATA)
         {
            this._statusTooltipData = new ToolTipVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this._battleConditions)
         {
            _loc1_.dispose();
         }
         this._battleConditions.splice(0,this._battleConditions.length);
         this._battleConditions = null;
         if(this.tokenConditions != null)
         {
            this.tokenConditions.cleanUp();
            this.tokenConditions = null;
         }
         if(this.awards != null)
         {
            for each(_loc1_ in this.awards)
            {
               _loc1_.dispose();
            }
            this.awards.cleanUp();
            this.awards = null;
         }
         this._statusTooltipData.dispose();
         this._statusTooltipData = null;
         super.onDispose();
      }
      
      public function get battleConditions() : Vector.<MissionConditionsContainerVO>
      {
         return this._battleConditions;
      }
      
      public function get statusTooltipData() : ToolTipVO
      {
         return this._statusTooltipData;
      }
   }
}
