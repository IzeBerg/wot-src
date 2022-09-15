package net.wg.gui.lobby.fortifications.battleRoom
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.advanced.IndicationOfStatus;
   import net.wg.gui.components.controls.TableRenderer;
   import net.wg.gui.components.controls.helpers.UserInfoTextLoadingController;
   import net.wg.gui.lobby.fortifications.data.sortie.SortieRenderVO;
   import net.wg.gui.rally.interfaces.IManualSearchRenderer;
   import net.wg.infrastructure.interfaces.IUserProps;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class SortieListRenderer extends TableRenderer implements IManualSearchRenderer
   {
      
      private static const IN_BATTLE_LABEL:String = "inBattle";
       
      
      public var commander:TextField = null;
      
      public var divisionName:TextField = null;
      
      public var description:TextField = null;
      
      public var commandSize:TextField = null;
      
      public var commandMaxSize:TextField = null;
      
      public var battleIndicator:IndicationOfStatus = null;
      
      protected var _userInfoTextLoadingController:UserInfoTextLoadingController = null;
      
      private var _creatorName:String = null;
      
      private var _description:String = null;
      
      public function SortieListRenderer()
      {
         super();
         preventAutosizing = true;
         this._userInfoTextLoadingController = new UserInfoTextLoadingController();
      }
      
      override public function setData(param1:Object) : void
      {
         var _loc2_:Array = null;
         this.data = param1;
         if(this.data)
         {
            _loc2_ = SortieRenderVO(param1).sortieID;
            if(_loc2_[0] != Values.DEFAULT_INT && _loc2_[1] != Values.DEFAULT_INT)
            {
               startSimulationDoubleClick();
            }
            else
            {
               stopSimulationDoubleClick();
            }
         }
         else
         {
            stopSimulationDoubleClick();
         }
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.commander.mouseEnabled = false;
         this.divisionName.mouseEnabled = false;
         this.commandSize.mouseEnabled = false;
         this.commandMaxSize.mouseEnabled = false;
         this._userInfoTextLoadingController.setControlledUserNameTextField(this.commander);
      }
      
      override protected function onDispose() : void
      {
         this.battleIndicator.dispose();
         this.battleIndicator = null;
         this.commander = null;
         this.divisionName = null;
         this.commandSize = null;
         this.commandMaxSize = null;
         this.description = null;
         this._description = null;
         this._userInfoTextLoadingController.dispose();
         this._userInfoTextLoadingController = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:SortieRenderVO = null;
         mouseEnabled = true;
         mouseChildren = true;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(data)
            {
               _loc1_ = SortieRenderVO(data);
               this.visible = true;
               this.populateUI(_loc1_);
            }
            else
            {
               this.visible = false;
            }
         }
      }
      
      public function update(param1:Object) : void
      {
         this.data = param1;
         if(this.data)
         {
            this.populateUI(SortieRenderVO(param1));
         }
      }
      
      protected function populateUI(param1:SortieRenderVO) : void
      {
         var _loc2_:String = null;
         var _loc3_:IUserProps = null;
         var _loc4_:IUserProps = null;
         if(param1.creatorName)
         {
            _loc3_ = App.utils.commons.getUserProps(param1.creatorName,"","",param1.igrType);
            _loc3_.rgb = param1.color;
            this._userInfoTextLoadingController.setUserNameFromProps(_loc3_);
            _loc2_ = this.commander.htmlText;
         }
         else
         {
            _loc2_ = "";
         }
         this._description = param1.description;
         this.description.htmlText = this._description;
         if(StringUtils.isNotEmpty(this.description.text))
         {
            this.description.visible = true;
            _loc4_ = App.utils.commons.getUserProps(param1.description,"","");
            App.utils.commons.formatPlayerName(this.description,_loc4_);
         }
         else
         {
            this.description.visible = false;
         }
         if(param1.isInBattle)
         {
            this.battleIndicator.visible = true;
            this.battleIndicator.gotoAndStop(IN_BATTLE_LABEL);
         }
         else
         {
            this.battleIndicator.visible = false;
         }
         if(this._creatorName != _loc2_)
         {
            this._creatorName = _loc2_;
         }
         _loc2_ = String(param1.playersCount);
         if(_loc2_ != this.commandSize.text)
         {
            this.commandSize.text = _loc2_;
         }
         _loc2_ = "/" + String(param1.commandSize);
         if(_loc2_ != this.commandMaxSize.text)
         {
            this.commandMaxSize.text = _loc2_;
         }
         this.divisionName.text = param1.divisionName;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         mouseEnabled = true;
         mouseChildren = true;
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         if(data == null)
         {
            return;
         }
         App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.FORT_SORTIE,null,data);
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         App.toolTipMgr.hide();
      }
      
      override protected function handleMouseRelease(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         super.handleMouseRelease(param1);
         if(param1.type == MouseEvent.CLICK)
         {
            _loc2_ = 0;
            if(_loc2_ != 0)
            {
               _loc2_ = data.rallyIndex;
            }
         }
      }
   }
}
