package net.wg.gui.notification.custom
{
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.common.containers.CenterAlignedGroupLayout;
   import net.wg.gui.components.containers.GroupEx;
   import net.wg.gui.lobby.components.AwardItemRendererEx;
   import net.wg.gui.notification.ServiceMessageContent;
   import net.wg.gui.notification.custom.vo.SMFunRandomRewardVO;
   import net.wg.utils.IClassFactory;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.data.DataProvider;
   
   public class SMFunRandomReward extends ServiceMessageContent
   {
      
      private static const BG_WIDTH:uint = 290;
      
      private static const BG_HEIGHT:uint = 400;
      
      private static const MAIN_REWARD_RENDERER_WIDTH:int = 232;
      
      private static const MAIN_REWARD_RENDERER_HEIGHT:int = 174;
      
      private static const REWARD_RENDERER_SIZE:int = 48;
      
      private static const REWARD_RENDERERS_GAP:int = 15;
      
      private static const MAIN_REWARD_OFFSET_Y:int = 2;
      
      private static const REWARDS_OFFSET_FROM_MAIN_REWARD:int = 10;
      
      private static const REWARDS_OFFSET_FROM_TEXT_FIELD:int = 26;
      
      private static const BUTTONS_GROUP_OFFSET_FROM_MAIN_REWARD:int = 30;
      
      private static const BUTTONS_GROUP_OFFSET_FROM_REWARDS:int = 39;
      
      private static const MESSAGE_PADDING_BOTTOM:int = 30;
       
      
      public var rewards:GroupEx;
      
      public var glowBg:Sprite;
      
      private var _mainReward:AwardItemRendererEx = null;
      
      private var _bgIconMask:Sprite = null;
      
      public function SMFunRandomReward()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:IClassFactory = App.utils.classFactory;
         this._mainReward = _loc1_.getComponent(Linkages.AWARD_RENDERER,AwardItemRendererEx);
         this._mainReward.setSize(MAIN_REWARD_RENDERER_WIDTH,MAIN_REWARD_RENDERER_HEIGHT);
         this.addChildAt(this._mainReward,getChildIndex(textField));
         this._bgIconMask = new Sprite();
         this._bgIconMask.graphics.beginFill(0);
         this._bgIconMask.graphics.drawRect(0,0,10,10);
         this._bgIconMask.graphics.endFill();
         this._bgIconMask.mouseEnabled = false;
         this._bgIconMask.mouseChildren = false;
         this._bgIconMask.x = bmpFill.x;
         this._bgIconMask.y = bmpFill.y;
         addChildAt(this._bgIconMask,getChildIndex(bgIcon));
         bgIcon.mask = this._bgIconMask;
         var _loc2_:CenterAlignedGroupLayout = new CenterAlignedGroupLayout(REWARD_RENDERER_SIZE,REWARD_RENDERER_SIZE);
         _loc2_.gap = REWARD_RENDERERS_GAP;
         this.rewards.layout = _loc2_;
         this.rewards.itemRendererLinkage = Linkages.AWARD_RENDERER;
         textField.selectable = false;
      }
      
      override protected function onDispose() : void
      {
         if(this._mainReward)
         {
            this._mainReward.dispose();
            this._mainReward = null;
         }
         bgIcon.mask = null;
         this._bgIconMask = null;
         this.rewards.dispose();
         this.rewards = null;
         this.glowBg = null;
         super.onDispose();
      }
      
      override protected function processCustomData(param1:Object) : void
      {
         var _loc2_:SMFunRandomRewardVO = new SMFunRandomRewardVO(param1);
         if(_loc2_.mainReward)
         {
            this._mainReward.data = _loc2_.mainReward;
            this._mainReward.visible = this.glowBg.visible = true;
         }
         else
         {
            this._mainReward.visible = this.glowBg.visible = false;
         }
         if(_loc2_.rewards && _loc2_.rewards.length > 0)
         {
            this.rewards.dataProvider = new DataProvider(_loc2_.rewards);
            this.rewards.visible = true;
         }
         else
         {
            this.rewards.visible = false;
         }
         if(StringUtils.isNotEmpty(_loc2_.bgIcon))
         {
            bgIcon.source = _loc2_.bgIcon;
         }
      }
      
      override protected function updateLayout() : void
      {
         if(timeComponent != null)
         {
            timeComponent.visible = false;
         }
         icon.visible = false;
         App.utils.commons.updateTextFieldSize(textField,false,true);
         textField.x = width - textField.width >> 1;
         this._mainReward.x = width - this._mainReward.width >> 1;
         this._mainReward.y = textField.y + textField.height + MAIN_REWARD_OFFSET_Y | 0;
         this.glowBg.x = this._mainReward.x + (this._mainReward.width - this.glowBg.width >> 1);
         this.glowBg.y = this._mainReward.y + (this._mainReward.height - this.glowBg.height >> 1);
         this.rewards.x = width >> 1;
         if(this._mainReward.visible)
         {
            this.rewards.y = this._mainReward.y + this._mainReward.height + REWARDS_OFFSET_FROM_MAIN_REWARD | 0;
         }
         else
         {
            this.rewards.y = textField.y + textField.height + REWARDS_OFFSET_FROM_TEXT_FIELD | 0;
         }
         buttonsGroup.x = width - buttonsGroup.width >> 1;
         if(this.rewards.visible)
         {
            buttonsGroup.y = this.rewards.y + REWARD_RENDERER_SIZE + BUTTONS_GROUP_OFFSET_FROM_REWARDS;
         }
         else
         {
            buttonsGroup.y = this._mainReward.y + MAIN_REWARD_RENDERER_HEIGHT + BUTTONS_GROUP_OFFSET_FROM_MAIN_REWARD;
         }
         var _loc1_:uint = buttonsGroup.y + buttonsGroup.height + MESSAGE_PADDING_BOTTOM;
         if(_loc1_ != background.height)
         {
            background.height = _loc1_;
            dispatchEvent(new Event(Event.RESIZE));
         }
         bgIcon.width = BG_WIDTH;
         bgIcon.height = BG_HEIGHT;
         bgIcon.x = width - BG_WIDTH >> 1;
         bgIcon.y = height - BG_HEIGHT >> 1;
         this._bgIconMask.width = width - (this._bgIconMask.x << 1);
         this._bgIconMask.height = height - (this._bgIconMask.y << 1);
      }
   }
}
