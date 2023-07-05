package net.wg.gui.lobby.personalMissions.components
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.personalMissions.data.PersonalMissionsAbstractInfoViewVO;
   import net.wg.infrastructure.base.meta.IPersonalMissionsAbstractInfoViewMeta;
   import net.wg.infrastructure.base.meta.impl.PersonalMissionsAbstractInfoViewMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class PersonalMissionsAbstractInfoView extends PersonalMissionsAbstractInfoViewMeta implements IPersonalMissionsAbstractInfoViewMeta
   {
      
      private static const INVALID_DATA_INIT:String = 