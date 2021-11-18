package net.wg.gui.lobby.personalMissions.components.chainsPanel
{
   import flash.display.MovieClip;
   import flash.filters.DropShadowFilter;
   import net.wg.data.constants.ComponentState;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.personalMissions.components.interfaces.IChainButton;
   import net.wg.gui.lobby.personalMissions.components.interfaces.IChainButtonContent;
   import net.wg.gui.lobby.personalMissions.data.ChainButtonVO;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class ChainButton extends SoundButtonEx implements IChainButton
   {
      
      private static const STATE_UNTOGGLE:String = "untoggle";
      
      private static const TUTORIAL_TEXT_STYLE_FILTER:DropShadowFilter = new DropShadowFilter(0,0,16711680,1,16,16,2,2);
       
      
      public var background:MovieClip;
      
      public var bgSelected:MovieClip;
      
      public var emptyFocusIndicator:MovieClip;
      
      public var content:IChainButtonContent = null;
      
      private var _toolTipMgr:ITooltipMgr = null;
      
      private var _chainID:int = -1;
      
      public function ChainButton()
      {
         super();
         soundEnabled = false;
      }
      
      override protected function showTooltip() : void
      {
         if(StringUtils.isNotEmpty(_tooltip))
         {
            this._toolTipMgr.showSpecial(_tooltip,null,this._chainID);
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._toolTipMgr = App.toolTipMgr;
         toggle = true;
         this.bgSelected.visible = false;
         allowDeselect = false;
         preventAutosizing = true;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.emptyFocusIndicator)
         {
            focusIndicator = this.emptyFocusIndicator;
         }
      }
      
      override protected function setState(param1:String) : void
      {
         var _loc2_:String = param1;
         var _loc3_:Boolean = selected && (param1 == ComponentState.TOGGLE || param1 == ComponentState.SELECTING);
         var _loc4_:Boolean = !selected && (param1 == ComponentState.TOGGLE || param1 == ComponentState.SELECTING);
         this.background.visible = !selected;
         if(_loc3_)
         {
            this.bgSelected.visible = true;
            this.setBackgroundState(ComponentState.TOGGLE);
         }
         else if(_loc4_)
         {
            _loc2_ = ComponentState.UP;
            this.setBackgroundState(STATE_UNTOGGLE);
         }
         this.content.setFilters(!!selected ? [TUTORIAL_TEXT_STYLE_FILTER] : null);
         super.setState(_loc2_);
      }
      
      override protected function onDispose() : void
      {
         this.content.dispose();
         this.content = null;
         this.background = null;
         this.bgSelected.stop();
         this.bgSelected = null;
         this.emptyFocusIndicator = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      private function setBackgroundState(param1:String) : void
      {
         this.bgSelected.gotoAndPlay(param1);
         if(this.background.visible)
         {
            this.background.gotoAndPlay(param1);
         }
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:ChainButtonVO = ChainButtonVO(param1);
         this._chainID = _loc2_.chainID;
         _tooltip = _loc2_.tooltip;
         this.content.update(param1);
         if(!selected)
         {
            this.content.setFilters(null);
         }
      }
      
      public function get chainID() : int
      {
         return this._chainID;
      }
   }
}
