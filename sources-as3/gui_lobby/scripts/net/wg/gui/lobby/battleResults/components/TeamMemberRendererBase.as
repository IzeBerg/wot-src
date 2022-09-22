package net.wg.gui.lobby.battleResults.components
{
   import flash.events.MouseEvent;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.lobby.battleResults.data.CommonStatsVO;
   import net.wg.gui.lobby.battleResults.data.TeamMemberItemVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.constants.InvalidationType;
   
   public class TeamMemberRendererBase extends SoundListItemRenderer
   {
      
      public static const INVALIDATE_COMMON_DATA:String = "inv_common_data";
      
      protected static const DEFAULT_TEAM_KILLER_COLOR:int = 65535;
       
      
      private var _vo:TeamMemberItemVO = null;
      
      private var _commonStatsVO:CommonStatsVO = null;
      
      private var _isDataChanged:Boolean;
      
      private var _isCommonStatsVOChanged:Boolean;
      
      public function TeamMemberRendererBase()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this._isDataChanged = true;
         this._vo = TeamMemberItemVO(param1);
         invalidateData();
      }
      
      override protected function onDispose() : void
      {
         this._commonStatsVO = null;
         this._vo = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._isDataChanged && isInvalid(InvalidationType.DATA))
         {
            this._isDataChanged = false;
            if(this._vo)
            {
               this.visible = true;
               this.showData(this._vo);
               invalidate(INVALIDATE_COMMON_DATA);
            }
            else
            {
               this.visible = false;
               this.selectable = false;
            }
         }
         if(this._isCommonStatsVOChanged && this._commonStatsVO && isInvalid(INVALIDATE_COMMON_DATA))
         {
            this._isCommonStatsVOChanged = false;
            this.updateCommonData(this._commonStatsVO);
         }
      }
      
      public function setCommonStatsVO(param1:CommonStatsVO) : void
      {
         this._isCommonStatsVOChanged = true;
         this._commonStatsVO = param1;
         invalidate(INVALIDATE_COMMON_DATA);
      }
      
      protected function updateCommonData(param1:CommonStatsVO) : void
      {
      }
      
      protected function showData(param1:TeamMemberItemVO) : void
      {
         throw new AbstractException(Errors.ABSTRACT_INVOKE);
      }
      
      protected function getColorForAlias(param1:String, param2:Number) : Number
      {
         var result:Number = NaN;
         var alias:String = param1;
         var defaultColor:Number = param2;
         try
         {
            result = App.colorSchemeMgr.getRGB(alias);
            if(!result)
            {
               result = defaultColor;
            }
         }
         catch(e:Error)
         {
            result = defaultColor;
         }
         return result;
      }
      
      public function get bonusType() : int
      {
         return Boolean(this._commonStatsVO) ? int(this._commonStatsVO.bonusType) : int(Values.DEFAULT_INT);
      }
      
      private function get wasInBattle() : Boolean
      {
         return Boolean(this._commonStatsVO) ? Boolean(this._commonStatsVO.wasInBattle) : Boolean(false);
      }
      
      override protected function handleMouseRelease(param1:MouseEvent) : void
      {
         var _loc2_:Object = null;
         if(App.utils.commons.isRightButton(param1) && this._vo)
         {
            _loc2_ = {
               "dbID":this._vo.playerId,
               "userName":this._vo.userVO.userName,
               "himself":this._vo.isSelf,
               "wasInBattle":this.wasInBattle,
               "showClanProfile":true,
               "clanAbbrev":this._vo.userVO.clanAbbrev,
               "vehicleCD":this._vo.vehicleCD,
               "clientArenaIdx":this._commonStatsVO.clientArenaIdx,
               "arenaType":this._commonStatsVO.arenaType,
               "isAlly":this._vo.isAlly
            };
            App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.BATTLE_RESULTS_USER,this,_loc2_);
         }
         super.handleMouseRelease(param1);
      }
   }
}
