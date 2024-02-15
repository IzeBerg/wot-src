package net.wg.gui.lobby.tankman
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.generated.SKILLS_CONSTANTS;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.TankmanTrainingSmallButton;
   import net.wg.gui.components.windows.Window;
   import net.wg.gui.lobby.tankman.vo.RetrainButtonVO;
   import net.wg.infrastructure.base.meta.ISkillDropMeta;
   import net.wg.infrastructure.base.meta.impl.SkillDropMeta;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.infrastructure.uilogging.epic_battle.EPIC_BATTLE_LOGGER_CONSTANTS;
   import net.wg.infrastructure.uilogging.epic_battle.SkillDropPageLogger;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ButtonGroup;
   import scaleform.clik.events.ButtonEvent;
   
   public class SkillDropWindow extends SkillDropMeta implements ISkillDropMeta
   {
      
      private static const SAVE_MODE_GROUP:String = 