package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   import net.wg.gui.lobby.badges.data.BadgeSuffixVO;
   import net.wg.gui.lobby.badges.data.BadgesGroupVO;
   import net.wg.gui.lobby.badges.data.BadgesStaticDataVO;
   import net.wg.gui.lobby.rankedBattles19.view.base.HangarRankedScreen;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BadgesPageMeta extends HangarRankedScreen
   {
       
      
      public var onBackClick:Function;
      
      public var onSelectBadge:Function;
      
      public var onDeselectBadge:Function;
      
      public var onSelectSuffixBadge:Function;
      
      public var onDeselectSuffixBadge:Function;
      
      public var onDummyButtonPress:Function;
      
      private var _badgesStaticDataVO:BadgesStaticDataVO;
      
      private var _badgesGroupVO:BadgesGroupVO;
      
      private var _badgesGroupVO1:BadgesGroupVO;
      
      private var _badgeVisualVO:BadgeVisualVO;
      
      private var _badgeSuffixVO:BadgeSuffixVO;
      
      public function BadgesPageMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._badgesStaticDataVO)
         {
            this._badgesStaticDataVO.dispose();
            this._badgesStaticDataVO = null;
         }
         if(this._badgesGroupVO)
         {
            this._badgesGroupVO.dispose();
            this._badgesGroupVO = null;
         }
         if(this._badgesGroupVO1)
         {
            this._badgesGroupVO1.dispose();
            this._badgesGroupVO1 = null;
         }
         if(this._badgeVisualVO)
         {
            this._badgeVisualVO.dispose();
            this._badgeVisualVO = null;
         }
         if(this._badgeSuffixVO)
         {
            this._badgeSuffixVO.dispose();
            this._badgeSuffixVO = null;
         }
         super.onDispose();
      }
      
      public function onBackClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onBackClick,"onBackClick" + Errors.CANT_NULL);
         this.onBackClick();
      }
      
      public function onSelectBadgeS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.onSelectBadge,"onSelectBadge" + Errors.CANT_NULL);
         this.onSelectBadge(param1);
      }
      
      public function onDeselectBadgeS() : void
      {
         App.utils.asserter.assertNotNull(this.onDeselectBadge,"onDeselectBadge" + Errors.CANT_NULL);
         this.onDeselectBadge();
      }
      
      public function onSelectSuffixBadgeS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.onSelectSuffixBadge,"onSelectSuffixBadge" + Errors.CANT_NULL);
         this.onSelectSuffixBadge(param1);
      }
      
      public function onDeselectSuffixBadgeS() : void
      {
         App.utils.asserter.assertNotNull(this.onDeselectSuffixBadge,"onDeselectSuffixBadge" + Errors.CANT_NULL);
         this.onDeselectSuffixBadge();
      }
      
      public function onDummyButtonPressS() : void
      {
         App.utils.asserter.assertNotNull(this.onDummyButtonPress,"onDummyButtonPress" + Errors.CANT_NULL);
         this.onDummyButtonPress();
      }
      
      public final function as_setStaticData(param1:Object) : void
      {
         var _loc2_:BadgesStaticDataVO = this._badgesStaticDataVO;
         this._badgesStaticDataVO = new BadgesStaticDataVO(param1);
         this.setStaticData(this._badgesStaticDataVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setReceivedBadges(param1:Object) : void
      {
         var _loc2_:BadgesGroupVO = this._badgesGroupVO;
         this._badgesGroupVO = new BadgesGroupVO(param1);
         this.setReceivedBadges(this._badgesGroupVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setNotReceivedBadges(param1:Object) : void
      {
         var _loc2_:BadgesGroupVO = this._badgesGroupVO1;
         this._badgesGroupVO1 = new BadgesGroupVO(param1);
         this.setNotReceivedBadges(this._badgesGroupVO1);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setSelectedBadge(param1:Object, param2:Boolean) : void
      {
         var _loc3_:BadgeVisualVO = this._badgeVisualVO;
         this._badgeVisualVO = new BadgeVisualVO(param1);
         this.setSelectedBadge(this._badgeVisualVO,param2);
         if(_loc3_)
         {
            _loc3_.dispose();
         }
      }
      
      public final function as_setBadgeSuffix(param1:Object) : void
      {
         var _loc2_:BadgeSuffixVO = this._badgeSuffixVO;
         this._badgeSuffixVO = new BadgeSuffixVO(param1);
         this.setBadgeSuffix(this._badgeSuffixVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setStaticData(param1:BadgesStaticDataVO) : void
      {
         var _loc2_:String = "as_setStaticData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setReceivedBadges(param1:BadgesGroupVO) : void
      {
         var _loc2_:String = "as_setReceivedBadges" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setNotReceivedBadges(param1:BadgesGroupVO) : void
      {
         var _loc2_:String = "as_setNotReceivedBadges" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setSelectedBadge(param1:BadgeVisualVO, param2:Boolean) : void
      {
         var _loc3_:String = "as_setSelectedBadge" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
      
      protected function setBadgeSuffix(param1:BadgeSuffixVO) : void
      {
         var _loc2_:String = "as_setBadgeSuffix" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
